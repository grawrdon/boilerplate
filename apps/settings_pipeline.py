PIPELINE_VERSION_REMOVE_OLD = True

PIPELINE_COMPILERS = (
    'pipeline.compilers.less.LessCompiler',
)

PIPELINE_CSS = {

    'core-styles': {
        'source_filenames': (
            'less/project.less',
        ),
        'output_filename': 'compiled/css/screen.grouped.css',
        'extra_context': {
            'media': 'all',
        },
    },

}

PIPELINE_JS = {

    'modernizr-scripts': {
        'source_filenames': (
            'lib/modernizr/modernizr.custom.js',
        ),
        'output_filename': 'compiled/js/modernizr.custom.js',
    },

}

