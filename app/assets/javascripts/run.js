/*
 Run on document ready, also for turbolinks
 */
$(document).on('turbolinks:load', function () {
    processUploads();
    attachDropzone();
});

/*
 Process all invoices with the press of one button
 */
var processUploads = function () {
    var processBtn = $('#process-btn');
    if (processBtn.length) {
        processBtn.on('click', function () {
            // Disable for 5 seconds
            var btn = $(this);
            btn.attr("disabled", "disabled");
            setTimeout(function () {
                btn.removeAttr('disabled');
            }, 1000);

            // Loop through all invoices and start pressing buttons
            $('#invoice-container, #attachment-container, #matched-container').find('a#match').click();
        });
    }
};

/*
 Drag and drop upload functionality
 */
var attachDropzone = function () {
    var pdfForm = $('#pdf-dropzone');
    if (pdfForm.length) {

        // Get the template HTML and remove it from the doument
        var previewsNode = $('#previews');
        var previewNode = $('#template');
        previewNode.id = '';
        var previewTemplate = previewsNode.html();
        previewsNode.empty();

        var pdfZone = new Dropzone($('#upload-container').get(0), {
            url: pdfForm.attr('action'),
            acceptedFiles: 'application/pdf,.pdf',
            parallelUploads: 10,
            uploadMultiple: false,
            previewTemplate: previewTemplate,
            autoQueue: true,
            previewsContainer: "#previews",
            clickable: false,
            params: {
                'authenticity_token': $('meta[name=csrf-token]').attr('content'),
                'job': pdfForm.find('input#job').val(),
                'category': pdfForm.find('input#category').val()
            }
        });

        pdfZone.on('success', function (file, response) {
            $(file.previewElement).hide();
            $.globalEval(response);
        });

        pdfZone.on('error', function (file) {
            $(file.previewElement).click(function () {
                $(this).hide();
            });
        });

        pdfZone.on('addedfile', function () {
            $('#upload-message').fadeOut();
        });

        pdfZone.on('queuecomplete', function () {
            $('#upload-message').fadeIn();
        });
    }
};