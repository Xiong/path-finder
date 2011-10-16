use 5.010001;
use strict;
use warnings;

use Test::More;
use Test::Trap qw( :default );

use File::HomeDir;

#~ use Devel::Comments '###';                                  # debug only #~
#~ use Devel::Comments '#####', ({ -file => 'tr-debug.log' });              #~

#============================================================================#
# 
# Play around with File::HomeDir.  

#----------------------------------------------------------------------------#
# SETUP

my $unit        = 'File::HomeDir: ';
my $got         ;
my $want        ;
my $diag        = $unit;
my $tc          = 0;

my @test_data   = (
    [
        -diag       => 'peek',
        -args       => undef,
        -return     => '',
    ],
    
); ## test_data

#----------------------------------------------------------------------------#
# EXECUTE AND CHECK

for my $i (0..$#test_data) {
    my $lineref     = $test_data[$i];
    my @line        = @$lineref;
    my @line_copy   = map { 
                        if    ( not defined $_ )        { q{} }
                        elsif ( $_ eq qq{\n} )          { q{\n} }
                        elsif ( $_ eq qq{\t} )          { q{\t} }
                        elsif ( ref $_ eq 'SCALAR' )    { $$_ }
                        elsif ( ref $_ eq 'ARRAY' )     { join q{.}, @$_ }
                        else                            { $_ } 
                    } @line;
##### in test script: 
##### @line_copy
    
    my $pass        = shift @line;
    my $want        = shift @line;
    my @given       = @line;
##### @given
    
    my $base   =  $unit . qq{<$i> } 
                . q{|}
                . ( join q{|}, @line_copy ) 
                . q{|}
                ;
    
    # EXECUTE
    my $rv = trap{    
        my $akin    = akin(@given);  
#~         say STDERR $akin;                    # debug the test only       #~
        my $rv      = $want =~ /$akin/;
        return $rv;
    };
##### $rv        
    # CHECK
    
#~     $trap->diag_all;                # Dumps the $trap object, TAP safe   #~
    
    $tc++;
    $diag   = $base . 'did_return';
    $trap->did_return($diag) or exit 1;
    
    $tc++;
    $diag   = $base . 'return value';
    $got    = $trap->return(0);
    $want   = $line{-return};
    is(  $got, $want, $diag ) or exit 1;
    
    $tc++;
    $diag   = $base . 'quiet';
    $trap->quiet($diag) or exit 1;      # no STDOUT or STDERR
        
    note(q{-});
}; ## for test_data

#----------------------------------------------------------------------------#
# TEARDOWN

END {
    done_testing($tc);                  # declare plan after testing
#~     done_testing();                  # declare no plan at all
}

#============================================================================#
