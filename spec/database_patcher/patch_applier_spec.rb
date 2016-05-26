require 'spec_helper'
describe DatabasePatcher::PatchApplier do
  let(:instance) { described_class.new }
  let(:connection) { DatabasePatcher::DB.create_connection }

  before do
    DatabasePatcher::Initializer.new.init
    connection[:installed_patches].truncate
    connection.run('DROP TABLE IF EXISTS test')
    connection.run('DROP TABLE IF EXISTS sample')
    allow($stdout).to receive(:puts)
  end

  describe '#up' do
    subject { instance.up }

    context 'when no patch file was applied before' do
      it 'should patch up file contect' do
        subject
        expect { connection.fetch('SELECT * FROM sample').all }.to_not raise_error
      end

      context 'and than one patch already made' do
        before { described_class.new.up }

        it 'should not apply same patch twice' do
          subject
          expect(connection[:installed_patches].count).to eq 3
        end
      end
    end
  end

  describe '#down' do
    subject { instance.down }

    context 'when no patch file was applied before' do
      it 'should not do anyting' do
        expect { subject }.to_not raise_error
      end

      context 'and than patching already made' do
        before { described_class.new.up }

        it 'should use down for remove patch that already applied' do
          expect(connection[:installed_patches].count).to eq 3
          subject
          expect(connection[:installed_patches].count).to eq 0
        end

        it 'should execute all the down commands' do
          subject

          expect { connection.fetch('SELECT * FROM sample').all }.to raise_error(Sequel::DatabaseError, /UndefinedTable/)
        end
      end
    end
  end

  describe '#rollback' do
    subject { instance.rollback }

    context 'when no patch file was applied before' do
      it 'should not do anyting' do
        expect { subject }.to_not raise_error
      end

      context 'and than patching already made' do
        before { described_class.new.up }

        it 'should use rollback for remove patch that already applied' do
          expect(connection[:installed_patches].count).to eq 3
          subject
          expect(connection[:installed_patches].count).to eq 2
        end

        it 'should execute all the rollback commands' do
          subject

          expect { connection.fetch('SELECT * FROM test').all }.to raise_error(Sequel::DatabaseError, /UndefinedTable/)
        end
      end
    end
  end
end
