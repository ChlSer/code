<?php
$array1 = array(
    array(1,  2,  3,  4  ),
    array(10, 11, 12, 5 ),
    array(9,  8,  7,  6 ),
);
$array = array(
    array(1,  2,  3,  4,  5,  6,  7),
    array(22, 23, 24, 25, 26, 27, 8),
    array(21, 36, 37, 38, 39, 28, 9),
    array(20, 35, 42, 41, 40, 29, 10),
    array(19, 34, 33, 32, 31, 30, 11),
    array(18, 17, 16, 15, 14, 13, 12),
);

const MOVE_RIGHT=0;
const MOVE_DOWN=1;
const MOVE_LEFT=2;
const MOVE_UP=3;

function move_to_right($a, &$D){

    for($i = $D['column_start']; $i < $D['column_finish']; $i++){
        echo ' '.$a[$D['row_start']][$i];
    }
    $D['row_start']++;
    $D['current_action'] = MOVE_DOWN;
}
function move_to_down($a, &$D){

    for($i = $D['row_start']; $i < $D['row_finish']; $i++){

        echo ' '.$a[$i][$D['column_finish']-1];

    }
    $D['column_finish']--;
    $D['current_action'] = MOVE_LEFT;
}
function move_to_left($a, &$D){

    for($i = $D['column_finish']-1; $i >= $D['column_start']; $i--){

        echo ' '.$a[$D['row_finish']-1][$i];

    }
    $D['row_finish']--;
    $D['current_action'] = MOVE_UP;
}
function move_to_up($a, &$D){

    for($i = $D['row_finish']-1; $i >= $D['row_start']; $i--){

        echo ' '.$a[$i][$D['column_start']];

    }
    $D['column_start']++;
    $D['current_action'] = MOVE_RIGHT;
}

function zmeia($a){
    $D = array(
        'current_row'=>0,
        'current_column'=>0,
        'current_action'=>MOVE_RIGHT,
        'column_start'=>0,
        'column_finish'=>count($a[0]), /*Конечный столбец*/
        'row_start'=>0,
        'row_finish'=>count($a), /*Конечная строка*/
    );
    $action_count = ($D['column_finish'] + $D['row_finish']) - 2;
    for($action=0; $action<$action_count; $action++){

        if($D['current_action']===MOVE_RIGHT){
            move_to_right($a, $D );
        }else
        if($D['current_action']===MOVE_DOWN){
            move_to_down($a, $D );
        }else
        if($D['current_action']===MOVE_LEFT){
            move_to_left($a, $D );
        }else
        if($D['current_action']===MOVE_UP){
            move_to_up($a, $D );
        }

    }

}
$start = microtime(true);
zmeia($array);
$time = microtime(true) - $start;
echo "<br>".$time;
?>
