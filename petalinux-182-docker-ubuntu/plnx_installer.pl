#!/tools/xgs/perl/5.8.5/bin/perl
#!/usr/bin/expect

use strict;
use warnings;
use Expect;
use File::Tail;

my($exp)  = new Expect; #Set exp for Expect

my $command;
my $line="PetaLinux SDK has been installed to";
$command="./petalinux-v2018.2-final-installer.run | grep \"PetaLinux Yocto SDK for microblaze has been successfully installed\"";

$exp-> spawn("$command")
or die "Cannot spawn $command: $!\n";

    if( $exp->expect(6000, 'Press Enter to display the license agreements')) {
	 sleep 5 ;
         $exp-> send("\n");
             }

    if( $exp->expect(6000, 'Do you accept Xilinx End User License Agreement')) {
         sleep 5 ;
         $exp-> send("y");
         $exp-> send("\n");
      	    }

   if( $exp->expect(6000, 'Do you accept Webtalk Terms and Conditions')) {
	 sleep 5 ;
         $exp-> send("y");
         $exp-> send("\n");
             }

  if( $exp->expect(6000, 'Do you accept Third Party End User License Agreement')) {
	sleep 5 ;
        $exp-> send("y");
        $exp-> send("\n");
             }

    if( $exp->expect(6000, 'Please input "y" to proceed the installation, "n" to exit otherwise')) {
	 sleep 5 ;
         $exp-> send("y");
          $exp-> send("\n");
        	}

     if( $exp->expect(6000, 'Please input "y" to continue to install PetaLinux in that directory?[n]')) {
         sleep 5 ;
          $exp-> send("y");
          $exp-> send("\n");
              }

 if ( $exp->expect(6000, 'PetaLinux SDK has been installed')) {
	$exp-> send("\n");
	    }

#system ($exp);
#my $file = File::Tail->new("./plnx_installer_run.log");
#while (defined(my $line= $file->read)) {
#    print $line;
#}

#$exp->soft_close();

