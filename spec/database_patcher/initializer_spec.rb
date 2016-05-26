require 'spec_helper'
describe DatabasePatcher::Initializer do
  let(:instance){ described_class.new }
  let(:connection) { DatabasePatcher::DB.create_connection }

  describe '#init' do
    subject { instance.init }

    context 'when no installed_patches table given in the database' do
      before { connection.run('DROP TABLE IF EXISTS installed_patches') }
      it 'should create a table' do
        subject

        expect { connection.fetch('SELECT * FROM installed_patches').all }.to_not raise_error
      end

      it 'should not try to create table if already done that' do
        2.times { subject }

        expect { connection.fetch('SELECT * FROM installed_patches').all }.to_not raise_error
      end
    end
  end
end
