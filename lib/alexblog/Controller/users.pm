package alexblog::Controller::users;
use Moose;
use namespace::autoclean;
use Digest::MD5;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

alexblog::Controller::users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched alexblog::Controller::users in users.');
}
 sub login :Local {
        my ($self, $c) = @_;
    
        # Get the username and password from form
        my $name = $c->request->params->{name};
        my $password = $c->request->params->{password};
    
        # If the username and password values were found in form
        if ($name && $password) {
            # Attempt to log the user in
            if ($c->authenticate({ name => $name,
                                   password => $password  } )) {
                # If successful, then let them use the application
$c->response->redirect($c->uri_for( $c->controller('posts')->action_for('list')));
                return;
            } else {
                # Set an error message
                $c->stash(error_msg => "Bad username or password.");
            }
        } else {
            # Set an error message
            $c->stash(error_msg => "Empty username or password.")
                unless ($c->user_exists);
        }
    
        # If either of above don't work out, send to the login page
        $c->stash(template => 'users/login.tt');
    }


sub logout :Local {
        my ($self, $c) = @_;
    
        # Clear the user's state
        $c->logout;
    
        # Send the user to the starting point
        $c->forward('login');
    }

sub list:Local{
my($self,$c)=@_;
$c->stash(users=>[$c->model('DB::User')->all]); 
$c->stash(template=>'users/list.tt');
}

sub base :Chained('/') :PathPart('users')
:CaptureArgs(0) {
my ($self, $c) = @_;
# Store the ResultSet in stash so it's available for other methods
$c->stash(resultset => $c->model('DB::User'));
# Print a message to the debug log
$c->log->debug('*** INSIDE BASE METHOD ***');
}

sub form_new :Chained('base') :PathPart('new'){
my ($self, $c) = @_;
$c->stash(template=>'users/new.tt');
}

sub form_create :Chained('base') :PathPart('create') :Args(0) {
my ($self, $c) = @_;
# Retrieve the values from the form
my $username = $c->request->params->{name} || 'N/A';
my $email = $c->request->params->{email} || 'N/A';
my $password= $c->request->params->{password} || 'N/A';
# Create the user
my $user = $c->model('DB::User')->create({
name => $username,
email => $email,
password => $password
});
# Store new model object in stash and set template
$c->response->redirect($c->uri_for($self->action_for('list')));
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
    
        # Redirect the user back to the list page with status msg as an arg
        $c->response->redirect($c->uri_for($self->action_for('list')));
    }

sub show :Chained('object') :PathPart('show'){
my ($self, $c) = @_;
$c->stash(user=>$c->stash->{object}); 
$c->stash(template=>'users/show.tt');
}

sub edit :Chained('object') :PathPart('edit'){
my ($self, $c) = @_;
$c->stash(user=>$c->stash->{object}); 
$c->stash(template=>'users/edit.tt');
}

sub update :Chained('object') :PathPart('update') :Args(0) {
       my ($self, $c) = @_;
# Retrieve the values from the form
my $username = $c->request->params->{name} || 'N/A';
my $email = $c->request->params->{email} || 'N/A';
my $password= $c->request->params->{password} || 'N/A';
# Create the user
my $user = $c->stash->{object}->update({
name => $username,
email => $email,
password => Digest::MD5::md5_hex($password)
});
    
        # Redirect the user back to the list page with status msg as an arg
        $c->response->redirect($c->uri_for($self->action_for('list')));
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
