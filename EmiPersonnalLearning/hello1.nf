#!/usr/bin/env nextflow

params.greeting  = 'Hello world!'
greeting_ch = Channel.from(params.greeting)

process splitLetters {

    input:
    val x from greeting_ch

    output:
    file 'chunk_*' into letters


    """
    printf '$x' | split -b 6 - chunk_
    """
}


process convertToUpper {

    input:
    file y from letters.flatten()

    output:
    stdout into result

    """
    rev $y
    """
}

result.view{ it.trim() }

hw_ch = Channel.from( 'hello', 'world' )
process mapf {
    input:
        val x from hw_ch
    script:
    """
    echo $x 
    """
}


hw_ch = Channel.from( 'Bonjour', 'world' )
process mapf2 {
    input:
        val x from hw_ch
    script:
    """
    echo $x 
    """
}

Channel
     .from( 'a', 'b', 'c' )
     .into{ foo; bar }

foo.view{ "Foo emits: " + it }
bar.view{ "Bar emits: " + it }