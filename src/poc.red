Red [
    Title: "POC"
    Description: "Prototype objects container"
    Purpose: "Ability to store objects safely in a map, with access control and type checking."
    Author: "Mateusz Palichleb"
    File: %poc.red
]

poc: context [
    /local registry: make map![]

    register: func [
        "Put object to container, identified by name"
        name[string!] prototype[object!]
    ] [
        if registered name [
            logic-error "There is already registered object with this name"
        ]

        put registry name prototype
    ]

    registered: func [
        "Check, that identifier is already registered"
        name[string!]
    ] [
        identifiers: words-of registry

        either not empty? identifiers [
            foreach identifier identifiers [
                result: identifier = name
                if result [break]
            ]

            result
        ] [
            false
        ]
    ]

    replace: func [
        "Replace object in container"
        name[string!] prototype[object!]
    ] [
	if not registered name [
            logic-error "Can not replace an unregistered object"
        ]

        put registry name prototype
    ]

    resolve: func [
        "Get object from container"
        name[string!]
    ] [
        if not registered name [
            logic-error "Can not resolve an unregistered object"
        ]

        prototype: select registry name
        make prototype []
    ]

    remove: func [
        "Remove object from container"
        name[string!]
    ] [
        if not registered name [
            logic-error "Can not remove an unregistered object"
        ]

        put registry name none
    ]

    /local logic-error: func [
        "Causing user error with provided message"
        message[string!]
    ] [
        cause-error 'user 'message [
            message
        ]
    ]
]
