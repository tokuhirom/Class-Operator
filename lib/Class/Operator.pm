package Class::Operator;
use strict;
use warnings;
use 5.00800;
our $VERSION = '0.01';
use parent qw/Exporter/;

our @EXPORT = qw/with mk_accessors method/;
our $TARGET;

sub with ($&) {
    my ($target, $code) = @_;
    local $TARGET = $target;
    $code->();
}

sub method ($&) {
    my ($name, $code) = @_;
    Carp::croak("missing context for " . __PACKAGE__) unless $TARGET;

    no strict 'refs';
    *{"${TARGET}\::${name}"} = $code;
}

sub mk_accessors($) {
    my ($name) = @_;

    no strict 'refs';
    *{"${TARGET}\::${name}"} = sub {
        $_[0]->{$name} = $_[1] if @_==2;
        return $_[0]->{$name};
    };
}

1;
__END__

=encoding utf8

=head1 NAME

Class::Operator -

=head1 SYNOPSIS

    package Counter2;
    use Class::Operator;

    sub import {
        my ($class, $opts) = @_;

        my $name = $opts->{name} // die;

        with caller(0) => sub {
            mk_accessors $name;
            method "increment_${name}" => sub {
                $_[0]->$name( $_[0]->$name + 1 );
            };
            method "reset_${name}" => sub {
                $_[0]->$name( 0 );
            };
        };
    }

=head1 DESCRIPTION

Class::Operator is

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
