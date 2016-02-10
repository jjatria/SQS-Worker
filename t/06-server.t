#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use Client::Json;
use Worker::Json;

if ( not defined $ENV{SQS_TEST_QUEUE} ) {
  plan skip_all => 'Can\'t test without SQS_TEST_QUEUE environment variable';
}


my $queue  = $ENV{SQS_TEST_QUEUE};
my $region = $ENV{SQS_TEST_REGION};

my $client = Client::Json->new(queue_url => $queue, region => $region);
$client->call(1, 'param2', [1,2,3], { a => 'hash' });

my $worker = Worker::Json->new(queue_url => $queue, region => $region);
$worker->fetch_message();


done_testing();