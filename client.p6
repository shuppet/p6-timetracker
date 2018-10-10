#!perl6

use Cro::WebSocket::Client;

my $supply = await Cro::WebSocket::Client.connect: :json, 'ws://localhost:3006';

react {
    whenever $supply.messages -> $message {
        # await doesn't work here, but jnthn is aware
        whenever $message.body { .say };
    }
}
