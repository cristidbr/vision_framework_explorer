//
//  VisionAPIDescription.swift
//  VisionKnit
//

import Foundation

var VisionAPIDescription: [VisionMethodDescription] =
[
    VisionMethodDescription(
        path: "classify",
        named: "Classification",
        icon: "signpost.right.and.left",
        title: "VNClassifyImageRequest",
        description:
            "Generate class probabilities for a given image. Returns an array of observations containing confidence levels for each supported class.",
        preview: .trailing,
        references: [
            CodeReference(url: "https://github.com/luoxuhai/react-native-classify-image", ranking: 28),
            CodeReference(url: "https://github.com/tmsm1999/Lepilens-iOS", ranking: 5),
            CodeReference(url: "https://github.com/nikitaame/DeepLook", ranking: 7),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-classify-image-1",
                credits: ImageCredits(
                    author: "Simon Shim", authorURL: "https://unsplash.com/@simonshim", service: "Unsplash",
                    serviceURL: "https://unsplash.com/photos/m_JBqorhyN0")),
            ImageSampleReference(
                path: "op-img-classify-image-2",
                credits: ImageCredits(
                    author: "Damir Kopezhanov", authorURL: "https://unsplash.com/@kpzhnv",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/luseu9GtYzM")),
            ImageSampleReference(
                path: "op-img-classify-image-3",
                credits: ImageCredits(
                    author: "Roberta Sorge", authorURL: "https://unsplash.com/@robertina",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/UvVVnUmW2mQ")),
        ]
    ),

    VisionMethodDescription(
        path: "barcodes",
        named: "Barcodes",
        icon: "barcode.viewfinder",
        title: "VNDetectBarcodesRequest",
        description:
            "Detect and extract information from barcodes in an image. Supports both 1D and 2D symbologies: Aztec, Codabar, Code 39, Code 93i, Code 128, Data Matrix, EAN-8, EAN-13, GS1 DataBar, GS1 DataBar Expanded, GS1 DataBar Limited, Interleaved 2 of 5 (ITF), ITF-14, MicroPDF417, MicroQR, PDF417, Quick Response (QR), UPC-E.",
        preview: .overlay,
        references: [
            CodeReference(url: "https://github.com/RxSwiftCommunity/RxVision", ranking: 13),
            CodeReference(url: "https://github.com/DavidPhillipOster/QRDecode", ranking: 2),
            CodeReference(url: "https://github.com/WICG/shape-detection-api", ranking: 292),
            CodeReference(url: "https://github.com/flutter-package/flutter_scan", ranking: 75),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-detect-barcodes-1",
                credits: ImageCredits(
                    author: "Amy-Leigh Barnard", authorURL: "https://unsplash.com/@amyb99",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/N7GfpgDSR0o")),
            ImageSampleReference(
                path: "op-img-detect-barcodes-2",
                credits: ImageCredits(
                    author: "Toa Heftiba", authorURL: "https://unsplash.com/@heftiba", service: "Unsplash",
                    serviceURL: "https://unsplash.com/photos/i05sF4afLYs")),
            ImageSampleReference(
                path: "op-img-detect-barcodes-3",
                credits: ImageCredits(
                    author: "Olivier Collet", authorURL: "https://unsplash.com/@ocollet",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/JMwCe3w7qKk")),
        ]
    ),

    VisionMethodDescription(
        path: "ocr",
        named: "Text recognition",
        icon: "text.viewfinder",
        title: "VNRecognizeTextRequest",
        description:
            "Find and recognize text in an image. Returns an array of results containing bounding boxes, each one containing multiple recognized text candidates. A recognized text candidate contains confidence level and recognized text string. ",
        preview: .split,
        references: [
            CodeReference(url: "https://github.com/aheze/OpenFind", ranking: 897),
            CodeReference(url: "https://github.com/appintheair/MRZScanner", ranking: 54),
            CodeReference(url: "https://github.com/RhetTbull/textinator", ranking: 120),
            CodeReference(url: "https://github.com/peterc/videocr/tree/main", ranking: 38),
            CodeReference(url: "https://github.com/khalid-asad/card-reader-ios", ranking: 117),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-recognize-text-1",
                credits: ImageCredits(
                    author: "Nathan Dumlao", authorURL: "https://unsplash.com/@nate_dumlao",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/pnFPbmcWB7g")),
            ImageSampleReference(
                path: "op-img-recognize-text-2",
                credits: ImageCredits(
                    author: "Marcel Strauß", authorURL: "https://unsplash.com/@martzzl",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/nUSggxVE7Xc")),
            ImageSampleReference(
                path: "op-img-recognize-text-3",
                credits: ImageCredits(
                    author: "Thought Catalog", authorURL: "https://www.pexels.com/@thought-catalog-317580/",
                    service: "Pexels",
                    serviceURL:
                    "https://www.pexels.com/photo/red-daisies-and-pink-roses-with-text-overlay-904623/")),
            ImageSampleReference(
                path: "op-img-recognize-text-4",
                credits: ImageCredits(
                    author: "Museums Victoria", authorURL: "https://unsplash.com/@museumsvictoria",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/SE5wx-EmRLo")),
        ]
    ),

    VisionMethodDescription(
        path: "document-segmentation",
        named: "Document segmentation",
        icon: "doc.viewfinder",
        title: "VNDetectDocumentSegmentationRequest",
        description:
            "Detects a rectangular region that contains text in the input image. Returns an array of observed rectangles that contain the corner vertices and a saliency mask.",
        preview: .split,
        references: [
            CodeReference(url: "https://github.com/wing3501/MyFetchApp", ranking: 1),
            CodeReference(url: "https://github.com/stuffmc/ImageOCR", ranking: 3),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-document-segmentation-1",
                credits: ImageCredits(
                    author: "Aidan Bartos", authorURL: "https://unsplash.com/@bartos", service: "Unsplash",
                    serviceURL: "https://unsplash.com/photos/A32DH4B0FBY")),
            ImageSampleReference(
                path: "op-img-document-segmentation-2",
                credits: ImageCredits(
                    author: "Nathan Dumlao", authorURL: "https://unsplash.com/@nate_dumlao",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/zIgmSQdTIpA")),
            ImageSampleReference(
                path: "op-img-document-segmentation-3",
                credits: ImageCredits(
                    author: "Madalyn Cox", authorURL: "https://unsplash.com/@madalyncox",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/jrvqnCoJUYU")),
        ]
    ),

    VisionMethodDescription(
        path: "human-segmentation",
        named: "Background",
        icon: "person.and.background.dotted",
        title: "VNGeneratePersonSegmentationRequest",
        description:
            "Produces a matte image for a person it finds in the input image. Returns an image mask that can be used for background removal.",
        preview: .split,
        references: [
            CodeReference(url: "https://github.com/fabio914/PersonSegmentationMacOS", ranking: 46),
            CodeReference(url: "https://github.com/john-rocky/SemanticImage", ranking: 88),
            CodeReference(url: "https://github.com/gxalpha/obs-mac-backgroundremoval", ranking: 25),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-human-segmentation-1",
                credits: ImageCredits(
                    author: "Levi Stute", authorURL: "https://unsplash.com/@levi_stute_cinematography",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/CFOVmE4rqOU")),
            ImageSampleReference(
                path: "op-img-human-segmentation-2",
                credits: ImageCredits(
                    author: "Marty O'Neill", authorURL: "https://unsplash.com/@drastic_graphics",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/9ujdLC6sOaM")),
            ImageSampleReference(
                path: "op-img-human-segmentation-3",
                credits: ImageCredits(
                    author: "RDNE Stock project", authorURL: "https://www.pexels.com/@rdne/",
                    service: "Pexels",
                    serviceURL:
                    "https://www.pexels.com/photo/male-professional-discussing-in-front-7647958/")),
            ImageSampleReference(
                path: "op-img-human-segmentation-4",
                credits: ImageCredits(
                    author: "ThisIsEngineering", authorURL: "https://www.pexels.com/@thisisengineering/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/woman-in-black-tank-top-3861962/")),
        ]
    ),

    VisionMethodDescription(
        path: "text-rectangles",
        named: "Text rectangles",
        icon: "character.textbox",
        title: "VNDetectTextRectanglesRequest",
        description:
            "Detect regions of visible text in an image. Can return rectangular bounding boxes for each character inside the detection. Does not perform optical character recognition (OCR). ",
        preview: .trailing,
        references: [
            CodeReference(url: "https://github.com/gali8/WhichFont", ranking: 82),
            CodeReference(url: "https://github.com/victor-pavlychko/OCRWorkshop", ranking: 5),
            CodeReference(url: "https://github.com/zsajjad/react-native-text-detector", ranking: 217),
            CodeReference(url: "https://github.com/bigsen/Vision_Demo", ranking: 87),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-detect-text-rectangles-1",
                credits: ImageCredits(
                    author: "Julian Hochgesang", authorURL: "https://unsplash.com/@julianhochgesang",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/o1p0BcIS03Y")),

            ImageSampleReference(
                path: "op-img-detect-text-rectangles-2",
                credits: ImageCredits(
                    author: "Yuliia Bas", authorURL: "https://www.pexels.com/@yuliia-bas-6230057/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/a-luxury-car-parked-on-the-street-5998732/")),

            ImageSampleReference(
                path: "op-img-detect-text-rectangles-3",
                credits: ImageCredits(
                    author: "Keegan Checks", authorURL: "https://www.pexels.com/@keegan-checks-1434513/",
                    service: "Pexels",
                    serviceURL:
                    "https://www.pexels.com/photo/tangerine-vehicle-parked-on-the-street-12126184/")),

            ImageSampleReference(
                path: "op-img-detect-text-rectangles-4",
                credits: ImageCredits(
                    author: "Adam Borkowski", authorURL: "https://unsplash.com/@borkography",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/R7GgJgRn0zQ")),

            ImageSampleReference(
                path: "op-img-detect-text-rectangles-5",
                credits: ImageCredits(
                    author: "Sandro Gonzalez", authorURL: "https://unsplash.com/@sandro",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/GCfW6bydZUc")),
        ]
    ),

    VisionMethodDescription(
        path: "face-rectangles",
        named: "Faces",
        icon: "face.dashed",
        title: "VNDetectFaceRectanglesRequest",
        description: "Finds faces within an image. Returns an array of bounding boxes. ",
        preview: .overlay,
        references: [
            CodeReference(url: "https://github.com/SwiftBrain/HelloVision", ranking: 95),
            CodeReference(url: "https://github.com/dimroc/count", ranking: 52),
            CodeReference(url: "https://github.com/mehmetkoca/Recogcis", ranking: 30),
            CodeReference(url: "https://github.com/xzzz9097/Machine", ranking: 4),
            CodeReference(url: "https://github.com/FluidGroup/Brightroom", ranking: 3016),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-face-rectangles-1",
                credits: ImageCredits(
                    author: "Daniel Xavier", authorURL: "https://www.pexels.com/@danxavier/",
                    service: "Pexels",
                    serviceURL:
                    "https://www.pexels.com/photo/low-angle-photography-of-female-on-carnival-814049/")),
            ImageSampleReference(
                path: "op-img-face-rectangles-2",
                credits: ImageCredits(
                    author: "Jennifer Marquez", authorURL: "https://unsplash.com/@jamscreativephotography",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/HvkDYluePqw")),
            ImageSampleReference(
                path: "op-img-face-rectangles-3",
                credits: ImageCredits(
                    author: "Martin Lopez", authorURL: "https://www.pexels.com/@mediocrememories/",
                    service: "Pexels",
                    serviceURL:
                    "https://www.pexels.com/photo/smiling-man-standing-and-dancing-near-smiling-woman-surrounded-with-people-2240771/"
                )),
        ]
    ),

    VisionMethodDescription(
        path: "face-quality",
        named: "Face quality",
        icon: "theatermasks",
        title: "VNDetectFaceCaptureQualityRequest",
        description:
            "Produces a floating-point number that represents the capture quality of a face in a photo. Returns an array of face observations.",
        preview: .overlay,
        references: [
            CodeReference(url: "https://github.com/LA-Labs/DeepLook", ranking: 27),
            CodeReference(url: "https://github.com/alexdong/autocrop", ranking: 1),
            CodeReference(url: "https://github.com/ObservantLabs/VisionUtils", ranking: 3),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-face-quality-1",
                credits: ImageCredits(
                    author: "Pixabay", authorURL: "https://www.pexels.com/@pixabay/", service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/people-festival-sitting-freedom-50709/")),
            ImageSampleReference(
                path: "op-img-face-quality-2",
                credits: ImageCredits(
                    author: "George Milton", authorURL: "https://www.pexels.com/@george-milton/",
                    service: "Pexels",
                    serviceURL:
                    "https://www.pexels.com/photo/positive-woman-near-microphone-in-room-6954192/")),
            ImageSampleReference(
                path: "op-img-face-quality-3",
                credits: ImageCredits(
                    author: "jinto mathew", authorURL: "https://www.pexels.com/@jinto-mathew-3071051/",
                    service: "Pexels",
                    serviceURL:
                    "https://www.pexels.com/photo/adult-man-and-woman-standing-in-kerala-wedding-outfits-11146331/"
                )),
        ]
    ),

    VisionMethodDescription(
        path: "face-landmarks",
        named: "Face landmarks",
        icon: "point.3.connected.trianglepath.dotted",
        title: "VNDetectFaceLandmarksRequest",
        description:
            "Finds facial features like eyes and mouth in an image. Returns an array of face observations, each one containing the detected landmarks and features. ",
        preview: .overlay,
        references: [
            CodeReference(url: "https://github.com/jfiguinha/Regards", ranking: 25),
            CodeReference(url: "https://github.com/xiaohk/FaceData", ranking: 71),
            CodeReference(url: "https://github.com/kravik/facevision", ranking: 47),
            CodeReference(url: "https://github.com/DroidsOnRoids/VisionFaceDetection", ranking: 259),
            CodeReference(url: "https://github.com/persello/norminal", ranking: 11),
            CodeReference(url: "https://github.com/MissEmlizB/Googly-Eyes", ranking: 4),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-face-landmarks-1",
                credits: ImageCredits(
                    author: "Hamid Tajik", authorURL: "https://unsplash.com/@hamidtajikph",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/uvnApE6gmnM")),
            ImageSampleReference(
                path: "op-img-face-landmarks-2",
                credits: ImageCredits(
                    author: "Omid Armin", authorURL: "https://unsplash.com/@omidarmin", service: "Unsplash",
                    serviceURL: "https://unsplash.com/photos/BQWmw-t0c_A")),
            ImageSampleReference(
                path: "op-img-face-landmarks-3",
                credits: ImageCredits(
                    author: "Antoni Shkraba", authorURL: "https://www.pexels.com/@shkrabaanthony/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/women-blowing-confetti-7507067/")),
            ImageSampleReference(
                path: "op-img-face-landmarks-4",
                credits: ImageCredits(
                    author: "MART PRODUCTION", authorURL: "https://www.pexels.com/@mart-production/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/snake-crawling-on-a-gypsum-head-8458843/")),
        ]
    ),

    VisionMethodDescription(
        path: "feature-print",
        named: "Feature print",
        icon: "pawprint",
        title: "VNGenerateImageFeaturePrintRequest",
        description:
            "Generate feature prints of the given image. Returns an Float vector of 2048 values that encode the image in separable space. Differences between images (or similarity) can be evaluated using the cosine distance applied between their encodings.",
        preview: .trailing,
        references: [
            CodeReference(url: "https://github.com/anupamchugh/iowncode", ranking: 825),
            CodeReference(url: "https://github.com/popCain/DetectionAndTracking_iOS", ranking: 5),
            CodeReference(url: "https://github.com/oguzveozturk/ImageSimilarity", ranking: 3),
            CodeReference(url: "https://github.com/matthewspear/StopTouchingYourFace", ranking: 9),
            CodeReference(url: "https://github.com/hollance/sefr-swift", ranking: 21),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-feature-print-1",
                credits: ImageCredits(
                    author: "Derek Thomson", authorURL: "https://unsplash.com/@derekthomson",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/TWoL-QCZubY")),
            ImageSampleReference(
                path: "op-img-feature-print-2",
                credits: ImageCredits(
                    author: "Rowan Heuvel", authorURL: "https://unsplash.com/@insolitus",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/U6t80TWJ1DM")),
            ImageSampleReference(
                path: "op-img-feature-print-3",
                credits: ImageCredits(
                    author: "Jane Doan", authorURL: "https://www.pexels.com/@hellojanedoan/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/top-view-photo-of-food-dessert-1099680/")),
            ImageSampleReference(
                path: "op-img-feature-print-4",
                credits: ImageCredits(
                    author: "Lorenzo Herrera", authorURL: "https://unsplash.com/@lorenzoherrera",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/p0j-mE6mGo4")),
        ]
    ),

    VisionMethodDescription(
        path: "contours",
        named: "Contours",
        icon: "pencil.and.outline",
        title: "VNDetectContoursRequest",
        description:
            "Detect the contours of the edges of an image. Returns an array of contours observations, each containing an unique set of several, non-enclosing contours.",
        preview: .split,
        references: [
            CodeReference(url: "https://github.com/juanj/Speech-Bubbles-Swift", ranking: 10),
            CodeReference(url: "https://github.com/AndreasInk/HackBack", ranking: 1),
            CodeReference(url: "https://github.com/beforeold/iOSDailyDemo", ranking: 4),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-detect-contours-1",
                credits: ImageCredits(
                    author: "Brendan Steeves", authorURL: "https://unsplash.com/@brendan_k_steeves",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/G-YAJ61qIuU")),
            ImageSampleReference(
                path: "op-img-detect-contours-2",
                credits: ImageCredits(
                    author: "Chris De Wit", authorURL: "https://unsplash.com/@skyxperience",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/JES_izhNmWY")),
            ImageSampleReference(
                path: "op-img-detect-contours-3",
                credits: ImageCredits(
                    author: "Bogdan Krupin", authorURL: "https://www.pexels.com/@bogdankrupin/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/green-apple-on-the-black-stone-17036350/")),
            ImageSampleReference(
                path: "op-img-detect-contours-4",
                credits: ImageCredits(
                    author: "Nothing Ahead", authorURL: "https://www.pexels.com/@ian-panelo/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/white-and-black-439-road-sign-3230204/")),
        ]
    ),

    VisionMethodDescription(
    path: "rectangles",
    named: "Rectangles",
    icon: "perspective",
    title: "VNDetectRectanglesRequest",
    description:
        "Finds projected rectangular regions. Returns an array of observed rectangles, each containing the corner vertices and scores. ",
    preview: .overlay,
    references: [
        CodeReference(url: "https://github.com/WeTransfer/WeScan", ranking: 2696),
        CodeReference(url: "https://github.com/wevat/rectangle-scanner", ranking: 9),
        CodeReference(url: "https://github.com/MATHEMA-GmbH/privacyblur", ranking: 116),
        CodeReference(url: "https://github.com/romy-aikon/Vision-ML-Example", ranking: 4),
        CodeReference(url: "https://github.com/john-rocky/SemanticImage", ranking: 88),
    ],
    samples: [
        ImageSampleReference(
        path: "op-img-detect-rectangles-1",
        credits: ImageCredits(
            author: "Bálint Szabó", authorURL: "https://unsplash.com/@thehighdynamic",
            service: "Unsplash", serviceURL: "https://unsplash.com/photos/wmAyFfBgK2I")),
        ImageSampleReference(
        path: "op-img-detect-rectangles-2",
        credits: ImageCredits(
            author: "Klaudia Piaskowska", authorURL: "https://unsplash.com/@cloudyaaa",
            service: "Unsplash", serviceURL: "https://unsplash.com/photos/fExzb1tHPzE")),
        ImageSampleReference(
        path: "op-img-detect-rectangles-3",
        credits: ImageCredits(
            author: "Eva Bronzini", authorURL: "https://www.pexels.com/@eva-bronzini/",
            service: "Pexels",
            serviceURL: "https://www.pexels.com/photo/black-dog-running-along-beach-15844087/")),
        ImageSampleReference(
        path: "op-img-detect-rectangles-4",
        credits: ImageCredits(
            author: "Matheus Viana", authorURL: "https://www.pexels.com/@prismattco/",
            service: "Pexels",
            serviceURL: "https://www.pexels.com/photo/black-dog-running-along-beach-15844087/")),
    ]
    ),

    VisionMethodDescription(
    path: "horizon",
    named: "Horizon",
    icon: "level",
    title: "VNDetectHorizonRequest",
    description:
        "Determine the horizon angle. Returns the angle and the affine transform required to level the image, if applicable.",
    preview: .split,
    references: [
        CodeReference(url: "https://github.com/miyako/4d-plugin-vision", ranking: 2)
    ],
    samples: [
        ImageSampleReference(
        path: "op-img-detect-horizon-1",
        credits: ImageCredits(
            author: "Nati", authorURL: "https://www.pexels.com/@nati-87264186/", service: "Pexels",
            serviceURL: "https://www.pexels.com/photo/black-dog-running-along-beach-15844087/")),
        ImageSampleReference(
        path: "op-img-detect-horizon-2",
        credits: ImageCredits(
            author: "Cameron Casey", authorURL: "https://www.pexels.com/@camcasey/",
            service: "Pexels",
            serviceURL: "https://www.pexels.com/photo/aircraft-flying-above-city-1686990/")),
        ImageSampleReference(
        path: "op-img-detect-horizon-3",
        credits: ImageCredits(
            author: "Mark Jordan", authorURL: "https://unsplash.com/@markjordan36",
            service: "Unsplash", serviceURL: "https://unsplash.com/photos/fExzb1tHPzE")),
    ]
    ),

    VisionMethodDescription(
    path: "humans",
    named: "Humans",
    icon: "person.fill.viewfinder",
    title: "VNDetectHumanRectanglesRequest",
    description:
        "Finds rectangular regions that contain people. Returns an array of human observations as bounding boxes, each one containing a flag for upper body observations. ",
    preview: .overlay,
    references: [
        CodeReference(url: "https://github.com/Uhucream/Simple-ID-Photo", ranking: 1)
    ],
    samples: [
        ImageSampleReference(
        path: "op-img-detect-humans-1",
        credits: ImageCredits(
            author: "Cedric Fauntleroy", authorURL: "https://www.pexels.com/@cedric-fauntleroy/",
            service: "Pexels",
            serviceURL:
            "https://www.pexels.com/photo/a-woman-in-a-business-meeting-doing-a-presentation-8154794/"
        )),
        ImageSampleReference(
        path: "op-img-detect-humans-2",
        credits: ImageCredits(
            author: "Clout Africa", authorURL: "https://unsplash.com/@cloutafrica",
            service: "Unsplash", serviceURL: "https://unsplash.com/photos/G0imwkNpLfM")),
        ImageSampleReference(
        path: "op-img-detect-humans-3",
        credits: ImageCredits(
            author: "Annie Spratt", authorURL: "https://unsplash.com/@anniespratt",
            service: "Unsplash", serviceURL: "https://unsplash.com/photos/QckxruozjRg")),
    ]
    ),

    VisionMethodDescription(
    path: "human-body-pose",
    named: "Body pose",
    icon: "figure.run",
    title: "VNDetectHumanBodyPoseRequest",
    description:
        "Detects human body poses. Returns and array of results, each containing the observed points and joint names.",
    preview: .overlay,
    references: [
        CodeReference(url: "https://github.com/al03/VisionPose", ranking: 14),
        CodeReference(url: "https://github.com/mayankgandhi/YogaVision", ranking: 8),
        CodeReference(url: "https://github.com/philippgehrke/SquatCounter", ranking: 18),
    ],
    samples: [
        ImageSampleReference(
        path: "op-img-human-body-pose-1",
        credits: ImageCredits(
            author: "cottonbro studio", authorURL: "https://www.pexels.com/@cottonbro/",
            service: "Pexels",
            serviceURL: "https://www.pexels.com/photo/woman-girl-animal-dog-4056535/")),
        ImageSampleReference(
        path: "op-img-human-body-pose-2",
        credits: ImageCredits(
            author: "Anastase Maragos", authorURL: "https://unsplash.com/@visualsbyroyalz",
            service: "Unsplash", serviceURL: "https://unsplash.com/photos/fG0p4Qh_aWI")),
        ImageSampleReference(
        path: "op-img-human-body-pose-3",
        credits: ImageCredits(
            author: "Monstera", authorURL: "https://www.pexels.com/@gabby-k/", service: "Pexels",
            serviceURL:
            "https://www.pexels.com/photo/multiracial-people-doing-reverse-triangle-pose-5384538/"
        )),
        ImageSampleReference(
        path: "op-img-human-body-pose-4",
        credits: ImageCredits(
            author: "Jonathan Chng", authorURL: "https://unsplash.com/@jon_chng",
            service: "Unsplash", serviceURL: "https://unsplash.com/photos/HgoKvtKpyHA")),
    ]
    ),

    VisionMethodDescription(
        path: "human-hand-pose",
        named: "Hand pose",
        icon: "hand.draw",
        title: "VNDetectHumanHandPoseRequest",
        description:
            "Detects human hand poses. Returns an array and array of results, each containing the observed points and joint names.",
        preview: .overlay,
        references: [
            CodeReference(url: "https://github.com/anupamchugh/iOS14VisionHandPose", ranking: 22),
            CodeReference(url: "https://github.com/john-rocky/RealityKit-Sampler", ranking: 112),
            CodeReference(url: "https://github.com/Reality-Dev/BodyTracking", ranking: 47),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-human-hand-pose-1",
                credits: ImageCredits(
                    author: "Jeff Hardi", authorURL: "https://unsplash.com/@jeffhardi", service: "Unsplash",
                    serviceURL: "https://unsplash.com/photos/LkPTJo7u6O8")),
            ImageSampleReference(
                path: "op-img-human-hand-pose-2",
                credits: ImageCredits(
                    author: "RDNE Stock project", authorURL: "https://www.pexels.com/@rdne/",
                    service: "Pexels",
                    serviceURL:
                    "https://www.pexels.com/photo/woman-in-white-long-sleeve-coat-doing-a-hand-sign-7240255/"
                )),
            ImageSampleReference(
                path: "op-img-human-hand-pose-3",
                credits: ImageCredits(
                    author: "Darina Belonogova", authorURL: "https://www.pexels.com/@darina-belonogova/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/a-woman-in-white-sleeveless-top-7886750/")),
            ImageSampleReference(
                path: "op-img-human-hand-pose-4",
                credits: ImageCredits(
                    author: "Hannah Busing", authorURL: "https://unsplash.com/@hannahbusing",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/Zyx1bK9mqmA")),
        ]
    ),

    VisionMethodDescription(
        path: "animals",
        named: "Animals",
        icon: "fish",
        title: "VNRecognizeAnimalsRequest",
        description:
            "Recognizes animals in an image. Returns an array of detected bounding boxes and classification scores for cat and dog.",
        preview: .overlay,
        references: [
            CodeReference(url: "https://github.com/john-rocky/AutoCatDogCam", ranking: 3),
            CodeReference(url: "https://github.com/ktustanowski/visiondemo", ranking: 19),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-detect-animals-1",
                credits: ImageCredits(
                    author: "Karsten Winegeart", authorURL: "https://unsplash.com/@karsten116",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/qy0BHykaq0E")),
            ImageSampleReference(
                path: "op-img-detect-animals-2",
                credits: ImageCredits(
                    author: "Beyzaa Yurtkuran",
                    authorURL: "https://www.pexels.com/@beyzaa-yurtkuran-279977530/", service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/cat-sitting-on-a-dresser-15435631/")),
            ImageSampleReference(
                path: "op-img-detect-animals-3",
                credits: ImageCredits(
                    author: "Nadia Vasil'eva", authorURL: "https://www.pexels.com/@nadialovesingle/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/person-holding-a-brown-dog-and-a-cat-6821106/"
                )),
        ]
    ),

    VisionMethodDescription(
        path: "attention-saliency",
        named: "Attention heatmap",
        icon: "dot.viewfinder",
        title: "VNGenerateAttentionBasedSaliencyImageRequest",
        description:
            "Produces a grayscale heat map that identifies the parts of an image most likely to draw attention. Its dimensions are 64 x 64 when fetched in real time (video), or 68 x 68 when performed on still images.",
        preview: .split,
        references: [
            CodeReference(url: "https://github.com/ktustanowski/visiondemo", ranking: 19),
            CodeReference(url: "https://github.com/sm1030/SaliencyPhotoBrowser", ranking: 1),
            CodeReference(url: "https://github.com/heestand-xyz/PixelKit", ranking: 838),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-attention-saliency-1",
                credits: ImageCredits(
                    author: "Vinicius \"amnx\" Amano", authorURL: "https://unsplash.com/@viniciusamano",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/4mK2KVuYrDs")),
            ImageSampleReference(
                path: "op-img-attention-saliency-2",
                credits: ImageCredits(
                    author: "Balázs Kétyi", authorURL: "https://unsplash.com/@balazsketyi",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/6ba_vdgx_go")),
            ImageSampleReference(
                path: "op-img-attention-saliency-3",
                credits: ImageCredits(
                    author: "Faruk Çolak", authorURL: "https://www.pexels.com/@f4rukcolak/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/traffic-light-and-no-turn-sign-15834609/")),
            ImageSampleReference(
                path: "op-img-attention-saliency-4",
                credits: ImageCredits(
                    author: "Touann Gatouillat Vergos", authorURL: "https://unsplash.com/@touann",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/aENmpXpbQX4")),
        ]
    ),

    VisionMethodDescription(
        path: "objectness-saliency",
        named: "Object heatmaps",
        icon: "vial.viewfinder",
        title: "VNGenerateObjectnessBasedSaliencyImageRequest",
        description:
            "Generate grayscale heat maps that identify the parts of an image most likely to represent objects. Returns at most 3 heat maps. Dimensions of the heat maps are 64 x 64 when fetched in real time (video), or 68 x 68 when performed on still images.",
        preview: .split,
        references: [
            CodeReference(url: "https://github.com/Piwigo/Piwigo-Mobile", ranking: 89),
            CodeReference(
            url: "https://github.com/AIwithSwift/PracticalAIwithSwift1stEd-Code", ranking: 78),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-objectness-saliency-1",
                credits: ImageCredits(
                    author: "Maria Salazar", authorURL: "https://www.pexels.com/@maria-salazar-303506/",
                    service: "Pexels",
                    serviceURL:
                    "https://www.pexels.com/photo/yellow-rose-flower-centerpiece-and-two-clear-champagne-flutes-878987/"
                )),
            ImageSampleReference(
                path: "op-img-objectness-saliency-2",
                credits: ImageCredits(
                    author: "Maria Ziegler",
                    authorURL: "https://unsplash.com/@schluesseldienstvergleich_eu", service: "Unsplash",
                    serviceURL: "https://unsplash.com/photos/6ba_vdgx_go")),
            ImageSampleReference(
                path: "op-img-objectness-saliency-3",
                credits: ImageCredits(
                    author: "KoolShooters", authorURL: "https://www.pexels.com/@koolshooters/",
                    service: "Pexels",
                    serviceURL: "https://www.pexels.com/photo/traffic-light-and-no-turn-sign-15834609/")),
        ]
    ),

    // TODO: Improve visualisation capabilities after release
    VisionMethodDescription(
        path: "core-ml-unsupported",
        named: "CoreML",
        icon: "m.square",
        title: "VNCoreMLRequest",
        description:
            "Use a Core ML model to process images. Inspect any model and its outputs by opening it in XCode.",
        preview: .overlay,
        references: [
            CodeReference(url: "https://github.com/godly-devotion/MochiDiffusion", ranking: 6500),
            CodeReference(url: "https://github.com/omarmhaimdat/face_ai", ranking: 105),
            CodeReference(url: "https://github.com/jsharp83/MetalCamera", ranking: 142),
            CodeReference(
                url: "https://github.com/tucan9389/SemanticSegmentation-CoreML", ranking: 286),
            CodeReference(
                url: "https://github.com/NovatecConsulting/FaceRecognition-in-ARKit", ranking: 823),
            CodeReference(url: "https://github.com/npna/CoreMLPlayer", ranking: 118),
        ],
        samples: [
            ImageSampleReference(
                path: "op-img-coreml-preview-1",
                credits: ImageCredits(
                    author: "Joshua Rawson-Harris", authorURL: "https://unsplash.com/@joshrh19",
                    service: "Unsplash", serviceURL: "https://unsplash.com/photos/YNaSz-E7Qss"),
                darkVersion: true)
        ]
    ),
]
