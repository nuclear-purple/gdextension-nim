import wrapped_header/gdextension_interface

var
  minimumInitializationLevel*: GDExtensionInitializationLevel
  gdnInterface*: ptr GDExtensionInterface
  library*: GDExtensionClassLibraryPtr
  initialization*: ptr GDExtensionInitialization
  token*: pointer = nil