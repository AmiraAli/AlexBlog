use utf8;
package alexblog::Schema::Result::Comment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

alexblog::Schema::Result::Comment

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<comments>

=cut

__PACKAGE__->table("comments");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 body

  data_type: 'text'
  is_nullable: 1

=head2 post_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "body",
  { data_type => "text", is_nullable => 1 },
  "post_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 post

Type: belongs_to

Related object: L<alexblog::Schema::Result::Post>

=cut

__PACKAGE__->belongs_to(
  "post",
  "alexblog::Schema::Result::Post",
  { id => "post_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 user

Type: belongs_to

Related object: L<alexblog::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "alexblog::Schema::Result::User",
  { id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-05-06 00:54:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LoT4lGRwFyNG6oSjIZq1zg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
