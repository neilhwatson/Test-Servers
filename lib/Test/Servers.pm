package Test::Servers;

use 5.10.0;
use strict;
use warnings FATAL => 'all';
use feature 'say';
use YAML::XS;
use Data::Dumper;
use Test::More;
use Net::OpenSSH;

=head1 NAME

Test::Servers - Test server configurations.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Test::Servers allows you to test one or more servers against a standard, in
YAML provided by you. 

   # yml config file
   hosts:
      - sol.example.com
      - saturn.example.com

   cfengine_tests:
      - test: package
        package_name: cfengine-community
        version_is: 3\.6\.5-1
      - test: process
        process_name: cf-execd
        user_is: root
        count_is: 1

The above standard states that the package cfengine-community, version 3.6.5-1
should be installed and that instance of the process cf-execd, own by root,
should running. This test is applied to the hosts sol and saturn. Run the tests
using the included test program.

   tservers cfengine.yml
   
=head1 LIMITATIONS

Only supports Red Hat and Debian based hosts at this time. Submissions to
improve this are always welcome.

=head1 AUTHOR

Neil H. Watson, C<< <neil at watson-wilson.ca> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-servers at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Servers>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::Servers

You can also look for information at:

=over 4

=item Source code on Github

L<https://github.com/neilhwatson/test-servers>

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Servers>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Servers>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-Servers>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-Servers/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2015 Neil H. Watson.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

our $t;

sub new
{
   my ( $class, %args ) = @_;
   bless {}, $class;

   ## TODO put this in new() ?
   $t = YAML::XS::LoadFile( $args{file} )
      or die "cannot open file [$args{file}] [$!]";

   return $class;
}

sub test_all
{
   print Dumper( \$t );
}

sub test_host
# Test a particular host instead of hosts listed in YML file.
{
   my $self = shift;
   my $host = shift;

   say "Testing host [$host]";
}

1; # End of Test::Servers
