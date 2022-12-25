
import wrapped_header/gdextension_interface
import internal
import core/variant as variant
include includes

export gdextension_interface
export variant


type
  ModuleInitializationLevel* = enum
    milCore = GDEXTENSION_INITIALIZATION_CORE,
    milServers = GDEXTENSION_INITIALIZATION_SERVERS,
    milScene = GDEXTENSION_INITIALIZATION_SCENE,
    milEditor = GDEXTENSION_INITIALIZATION_EDITOR,
  
  Callback* = proc(lvl: ModuleInitializationLevel): void {.nimcall.}

  InitCallbacks* = tuple
    initializeCallback, deinitializeCallback: Callback
  
  InitArguments* = tuple
    pInterface: ptr GDExtensionInterface
    pLibrary: GDExtensionClassLibraryPtr
    rInitialization: ptr GDExtensionInitialization


type GDExtensionIntializeDefect* = object of Defect


var g: InitCallbacks



proc initializeLevel(userdata: pointer, pLevel: GDExtensionInitializationLevel): void {.gdnExport.} =
  let cb = g.initializeCallback
  if not cb.isNil():
    cb cast[ModuleInitializationLevel](pLevel)


proc deinitializeLevel(userdata: pointer, pLevel: GDExtensionInitializationLevel): void {.gdnExport.} =
  let cb = g.deinitializeCallback
  if not cb.isNil():
    cb cast[ModuleInitializationLevel](pLevel)


proc init*(args: InitArguments, callbacks: InitCallbacks): void =
  (gdnInterface, library, token) = args
  args.rInitialization.initialize = initializeLevel
  args.rInitialization.deinitialize = deinitializeLevel
  args.rInitialization.minimum_initialization_level = minimumInitializationLevel
  g = callbacks
  
  #* init all things here
  variant.initBindings()


proc setMinimumLibraryInitializationLevel*(pLevel: ModuleInitializationLevel): void =
  minimumInitializationLevel = cast[GDExtensionInitializationLevel](pLevel)

