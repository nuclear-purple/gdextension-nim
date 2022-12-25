import ../wrapped_header/gdextension_interface
import variant


type MethodBind* = object
  name: cstring
  instanceClass: cstring
  argCount: int
  hintFlags: uint32
  isStatic, isConst, hasReturn, isVararg: bool
  argNames: seq[cstring]
  argTypes: ptr GDExtensionVariantType
  defaultArguments: seq[GodotVariant]


