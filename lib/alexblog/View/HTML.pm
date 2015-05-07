package alexblog::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

alexblog::View::HTML - TT View for alexblog

=head1 DESCRIPTION

TT View for alexblog.

=head1 SEE ALSO

L<alexblog>

=head1 AUTHOR

amira,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
