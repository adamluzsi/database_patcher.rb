# some comment here
create_table(:test) do
  primary_key(:id)
  String :comment, :size => 64
end
