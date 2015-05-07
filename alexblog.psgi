use strict;
use warnings;

use alexblog;

my $app = alexblog->apply_default_middlewares(alexblog->psgi_app);
$app;

