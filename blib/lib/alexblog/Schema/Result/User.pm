use utf8;
package alexblog::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

alexblog::Schema::Result::User

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

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 comments

Type: has_many

Related object: L<alexblog::Schema::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "alexblog::Schema::Result::Comment",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 posts

Type: has_many

Related object: L<alexblog::Schema::Result::Post>

=cut

__PACKAGE__->has_many(
  "posts",
  "alexblog::Schema::Result::Post",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-05-06 00:54:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mseJ2p6fBINP8NONr30eGQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
