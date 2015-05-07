use strict;
use warnings;
use Test::More;


use Catalyst::Test 'alexblog';
use alexblog::Controller::users;

ok( request('/users')->is_success, 'Request should succeed' );
done_testing();
