package Act::News;
use strict;
use DateTime;
use Act::Object;
use base qw( Act::Object );

# class data used by Act::Object
our $table       = 'news';
our $primary_key = 'news_id';

our %sql_stub    = (
    select => "n.*",
    from   => "news n",
);
our %sql_mapping = (
    # standard stuff
    map( { ($_, "(n.$_=?)") }
         qw( news_id conf_id lang user_id datetime title text published ) )
);
our %sql_opts    = ( 'order by' => 'datetime desc' );

sub content {
    join( "\n", map "<p>$_</p>", split /(?:\r?\n)+/, $_[0]->text)
}
sub create {
    my ($class, %args ) = @_;
    $args{datetime} = DateTime->now();
    return $class->SUPER::create(%args);
}

=head1 NAME

Act::News - An Act object representing a news item.

=head1 DESCRIPTION

This is a standard Act::Object class. See Act::Object for details.

=cut

1;