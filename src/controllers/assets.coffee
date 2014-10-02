module.exports =
  templates:
    handler:
      directory:
        path: "assets/templates"

    app:
      name: "templates"

  images:
    handler:
      directory:
        path: "assets/images"

    app:
      name: "images"

  css:
    handler:
      directory:
        path: "./app/assets"
        listing: true
    app:
      name: "css"

  js:
    handler:
      directory:
        path: "./app/assets"
    app:
      name: "js"

  bower:
    handler:
      directory:
        path: "assets/libs"

    app:
      name: "bower"