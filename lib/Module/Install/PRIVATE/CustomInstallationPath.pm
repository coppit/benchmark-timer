package Module::Install::PRIVATE::CustomInstallationPath;

use strict;

use vars qw( @ISA $VERSION );

use Module::Install::Base;
@ISA = qw( Module::Install::Base );

# ---------------------------------------------------------------------------

sub Check_Custom_Installation
{
  my $self = shift;

  return if (grep {/^PREFIX=/} @ARGV) || (grep {/^INSTALLDIRS=/} @ARGV);

  my $install_location = $self->prompt(
    "Choose your installation type:\n[1] normal Perl locations\n" .
    "[2] custom locations\n=>" => '1');

  if ($install_location eq '2')
  {
    my $home = Get_Home_Directory();

    print "\n","-"x78,"\n\n";

    my $prefix = $self->prompt(
      "What PREFIX should I use?\n=>" => $home);

    push @ARGV,"PREFIX=$prefix";
  }
}

# ---------------------------------------------------------------------------

# Figures out the user's home directory in Unix

sub Get_Home_Directory
{
  # Get the user's home directory. First try the password info, then the
  # registry (if it's a Windows machine), then any HOME environment variable.
  my $home = eval { (getpwuid($>))[7] } || $ENV{HOME};

  die <<"  EOF"
Your home directory could not be determined. I tried to get your
home directory using both getpwuid and your HOME environment variable.
  EOF
    unless defined $home;

  return $home;
}

1;
