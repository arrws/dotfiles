#!/usr/bin/env perl
use lib "/nix/store/xk7pw4vbdkxy0kbfhyyxyj273xy737dq-perl5.34.0-Audio-FLAC-Header-2.4/lib/perl5/site_perl/5.34.0";
use lib "/nix/store/8ch6jcbaglfgvkaxqipm3g82vx3cdr3c-perl5.34.0-File-Slurp-9999.32/lib/perl5/site_perl/5.34.0";
use v5.14;
use Audio::FLAC::Header;
use File::Temp qw/tempfile/;
use File::Slurp qw/write_file/;
use List::Util qw/shuffle/;
use MIME::Base64 qw/encode_base64/;
use Data::Dumper qw/Dumper/;

@ARGV = <*.flac> unless @ARGV;
$|=1;

for my $in (shuffle @ARGV) {
	my $out = $in =~ s/.flac$/.aac/r;
	my $wav = $in =~ s/.flac$/.wav/r;
	next if -f $out && -M $out < -M $in && -M $out < -M '/home/marius/bin/update-aacs';
	my $temp = ".$out$$.mp4";
	system flac => -d => $in;

	my $flac = Audio::FLAC::Header->new($in);
	my %tags = %{$flac->tags};
	# my @args = qw/-m1 -p29/;    # minimum quality
	my @args = qw/-m5 -p2/;     # maximum quality
	if ($flac->picture(3)) {
		write_file "$temp-front.jpg", $flac->picture(3)->{imageData};
		push @args, '--tag-from-file', "covr:$temp-front.jpg";
	}

	my %table = qw/TITLE nam ARTIST ART ALBUMARTIST aART ALBUM alb COMPOSER wrt GENRE gen DATE day/;
	push @args, $tags{$_} ? ('--tag' => "$table{$_}:$tags{$_}") : () for keys %table;
	system fdkaac => @args, -o => $temp, $wav;
	unlink $wav;
	unlink "$temp-front.jpg";
	rename $temp, $out;
}
