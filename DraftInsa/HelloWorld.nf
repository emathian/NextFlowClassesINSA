#!/usr/bin/env nextflow

params.greeting  = 'Hello world!'
greeting_ch = Channel.from(params.greeting)

process SayHello {
    echo true

    input:
    val x from greeting_ch

    output:
    stdout into receiver
    
    script:
    """
    echo $x
    """
}


receiver.view()


