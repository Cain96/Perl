#!/usr/local/bin/perl
#
# Very Simple Editor
#

use Tk;

$mw = MainWindow->new();
$mw->title("Very Simple Editor");

#
# $B%\%?%s$H%U%!%$%kL>%(%s%H%j$r3JG<$9$k%U%l!<%`$r:n@.(B
#
$top = $mw->Frame(-borderwidth => 10);
$top->pack(-side => 'top', -fill => 'x');

#
# $B%\%?%s$H%U%!%$%kL>%(%s%H%j$r:n@.(B, $BG[CV(B
#
$quit = $top->Button(-text => 'Quit', -command => sub { exit });
$clear = $top->Button(-text => 'Clear', -command => \&clear_text);
$save = $top->Button(-text => 'Save', -command => \&save_text);
$label = $top->Label(-text => 'Filename:', -padx => 0);
$filename = $top->Entry(-width => 20,
			-relief => 'sunken',
			-textvariable => \$savefilename);
$label->pack(-side => 'left');
$filename->pack(-side => 'left');
$quit->pack(-side => 'right');
$clear->pack(-side => 'right');
$save->pack(-side => 'right');

#
# $B%(%G%#%C%H$KMxMQ$9$k%F%-%9%H%&%#%8%'%C%H$r:n@.(B
#
$textframe = $mw->Frame();
$scroll = $textframe->Scrollbar();
$textfield = $textframe->Text(-width => 80,
			      -height => 25,
			      -borderwidth => 2,
			      -relief => 'sunken',
			      -setgrid => 1,
			      -yscrollcommand => ['set' => $scroll]);
$scroll->configure(-command => ['yview' => $textfield]);
$scroll->pack(-side => 'right', -fill => 'y');
$textfield->pack(-side => 'left', -fill => 'both', -expand => 1);
$textframe->pack(-side => 'top', -fill => 'both', -expand => 1);

#
# $BI=<((B
#
MainLoop;

#
# Clear$B%\%?%s$KBP1~$9$k<jB3$-(B
# $B%(%G%#%C%HCf$N%F%-%9%H$r$9$Y$F:o=|$9$k(B
#
sub clear_text {
    $textfield->delete('1.0','end');
}

#
# Save$B%\%?%s$KBP1~$9$k<jB3$-(B
# filename$B%(%s%H%j$K5-=R$5$l$?%U%!%$%kL>$G%U%!%$%k$r%*!<%W%s$7(B, 
# $B%F%-%9%H%&%#%8%'%C%H$NFbMF$r$=$N%U%!%$%k$X=q$-9~$`(B
#
sub save_text {
    open(OUTFILE, ">$savefilename")
	or warn("Can't open '$savefilename'"), return;
    print OUTFILE $textfield->get('1.0','end');
    close(OUTFILE);
}


