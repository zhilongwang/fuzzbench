#!/usr/local/bin/php
<?php
    print "$argc arguments were passed. In order: \n";

    for ($i = 0; $i <= $argc -1; ++$i) {
        print "$i: $argv[$i]\n";
    }
?>
