package Pod::Usage::Return;
{
  $Pod::Usage::Return::VERSION = '0.002';
}
# ABSTRACT: pod2usage that returns instead of exits

use strict;
use warnings;
use Pod::Usage ();
use base 'Exporter';
our @EXPORT = qw( pod2usage );

sub pod2usage {
    my $exitval = 2;
    my %args;
    if ( @_ == 1 ) {
        if ( ref $_[0] eq 'HASH' ) {
            %args = %{$_[0]};
        }
        elsif ( $_[0] =~ /^\d+$/ ) {
            $exitval = $_[0];
        }
        else {
            $args{-message} = $_[0];
            $args{-verbose} = 0;
        }
    }
    else {
        %args = @_;
    }
    $args{-exitval} = 'NOEXIT';
    if ( $exitval >= 2 ) {
        $args{-output} = *STDERR;
    }
    Pod::Usage::pod2usage( \%args );
    return $exitval;
}

1;

__END__

=pod

=head1 NAME

Pod::Usage::Return - pod2usage that returns instead of exits

=head1 VERSION

version 0.002

=head1 SYNOPSIS

    use Pod::Usage::Return;
    use Pod::Usage::Return qw( pod2usage );

    exit pod2usage(0);

    sub main {
        return pod2usage("ERROR: An error occurred!") if $ERROR;
    }

    exit pod2usage( -exitval => 1, -message => 'ERROR: An error occurred' );

=head1 DESCRIPTION

This is a drop-in replacement for L<Pod::Usage> C<pod2usage> that returns the
exit value instead of calling exit.g

=head1 FUNCTIONS

=head2 pod2usage

See L<Pod::Usage> for documentation. Returns the exit code instead of calling
exit().

=head1 AUTHOR

Doug Bell <preaction@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Doug Bell.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut