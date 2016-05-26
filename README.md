# DatabasePatcher

This is a tool for making database schema changes in our project.
This is a CLI tool

This tool has two convention to follow
  * It will use the project_root/db/patches folder for look up any change request
  * It will create and maintain an :installed_patches table

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'database_patcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install database_patcher

## Usage

```
The following commands supported:

	Command: help
	Description: show command specific help message

	Command: create_patch
	aliases: add, new
	Description: create a new patch file with this tools convention

	Command: initialize
	aliases: init, setup
	Description: this will create initial directory and the default installed_patches table in the database

	Command: apply_pending_patches
	aliases: apply, up
	Description: apply all pending db patch

	Command: execute_all_remove_patch
	aliases: apply, up
	Description: execute the down patches and remove all db patch

	Command: rollback
	aliases: revert, step_back
	Description: execute the last patch down part, and remove the db patch registration

```

### Example use

  $ database_patcher create_patch create some test table
  #> return the patch path
  # use <your favorite editor> to edit the file/files
  $ database_patcher apply_pending_patches
