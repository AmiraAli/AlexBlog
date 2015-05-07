package alexblog::Controller::comments;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

alexblog::Controller::comments - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched alexblog::Controller::comments in comments.');
}

sub list:Local{
my($self,$c)=@_;
$c->stash(comments=>[$c->model('DB::Comment')->all]); 
$c->stash(template=>'posts/list.tt');
}

sub base :Chained('/') :PathPart('comments')
:CaptureArgs(0) {
my ($self, $c) = @_;
# Store the ResultSet in stash so it's available for other methods
$c->stash(resultset => $c->model('DB::Comment'));
# Print a message to the debug log
$c->log->debug('*** INSIDE BASE METHOD ***');
}

sub form_new :Chained('base') :PathPart('new') :Args(0){
my ($self, $c) = @_;
$c->stash(template=>'comments/new.tt');
}

sub form_create :Chained('base') :PathPart('create') :Args(0) {
my ($self, $c) = @_;
# Retrieve the values from the form
my $postid = $c->request->params->{postid} || 'N/A';
my $body = $c->request->params->{body} || 'N/A';
my $userid = $c->request->params->{userid} || 'N/A';
my $comment = $c->model('DB::Comment')->create({
body => $body,
post_id => $postid,
user_id =>$userid
});
# Store new model object in stash and set template
$c->response->redirect($c->uri_for( $c->controller('posts')->action_for('list')));
}
sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
        # $id = primary key of book to delete
        my ($self, $c, $id) = @_;
    
        # Find the book object and store it in the stash
        $c->stash(object => $c->stash->{resultset}->find($id));
    
        # Make sure the lookup was successful.  You would probably
        # want to do something like this in a real app:
        #   $c->detach('/error_404') if !$c->stash->{object};
        die "Book $id not found!" if !$c->stash->{object};
    
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
    }

sub delete :Chained('object') :PathPart('delete') :Args(0) {
        my ($self, $c) = @_;
    
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        $c->stash->{object}->delete;
    
        # Redirect the post back to the list page with status msg as an arg
$c->response->redirect($c->uri_for( $c->controller('posts')->action_for('list')));
    }

sub edit :Chained('object') :PathPart('edit'){
my ($self, $c) = @_;
$c->stash(comment=>$c->stash->{object}); 
$c->stash(template=>'comments/edit.tt');
}

sub update :Chained('object') :PathPart('update') :Args(0) {
       my ($self, $c) = @_;
# Retrieve the values from the form
my $body = $c->request->params->{body} || 'N/A';
# Create the post
my $post = $c->stash->{object}->update({
body => $body
});
    
        # Redirect the post back to the list page with status msg as an arg
$c->forward('/util/redirect', [ $c->controller('posts')->action_for('list') ] );
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
