use strict;
use warnings;
use Test::More;


use Catalyst::Test 'alexblog';
use alexblog::Controller::comments;

ok( request('/comments')->is_success, 'Request should succeed' );
done_testing();
