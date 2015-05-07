package alexblog::Controller::posts;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

alexblog::Controller::posts - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched alexblog::Controller::posts in posts.');
}

sub list:Local{
my($self,$c)=@_;
$c->stash(posts=>[$c->model('DB::Post')->all]); 
$c->stash(comments=>[$c->model('DB::Comment')->all]); 
$c->stash(template=>'posts/list.tt');
}



=encoding utf8

=head1 AUTHOR

amira,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
