#!perl6

use Cro::HTTP::Router::WebSocket;
use Cro::HTTP::Router;
use Cro::HTTP::Server;

my $tick = Supply.interval(1);

my $app = route {
    get -> {
        web-socket :json, -> $incoming {
            supply {
                whenever $tick -> $tock {
                    emit {
                        time => time,
                        i => $tock
                    };
                }
            }
        }
    }
};

my $http-server = Cro::HTTP::Server.new(port => 3006, application => $app);
$http-server.start();
react whenever signal(SIGINT) {
    $http-server.stop();
    exit;
}
