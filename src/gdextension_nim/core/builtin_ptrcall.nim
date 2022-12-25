import ../wrapped_header/gdextension_interface
import sequtils, sugar


when not defined(GODOT_NIM_BUILTIN_PTRCALL):
    const GODOT_NIM_BUILTIN_PTRCALL* = true


template callBuiltinConstructor*[C](constructor: GDExtensionPtrConstructor, base: GDExtensionTypePtr, args: varargs[typed]): untyped =
    var call_args: array[GDExtensionTypePtr, args.len()] = array(a.map(x => addr x))
    constructor(base, addr call_args[0])


template callBuiltinMethodPtrRet*[T](met: GDExtensionPtrBuiltInMethod, base: GDExtensionTypePtr, args: varargs[typed]): T =
    var call_args: array[GDExtensionTypePtr, args.len()] = array(a.map(x => addr x))
    met(base, addr call_args, addr result, args.len())


template callBuiltinMethodPtrNoRet*(met: GDExtensionPtrBuiltinMethod, base: GDExtensionTypePtr, args: varargs[typed]): void =
    var call_args: array[GDExtensionTypePtr, args.len()] = array(a.map(x => addr x))
    met(base, addr call_args[0], nil, args.len())


template callBuiltinOperatorPtr*[T](op: GDExtensionPtrOperatorEvaluator, left: GDExtensionTypePtr, right: GDExtensionTypePtr): T =
    op(left, right, addr result)


template callBuiltinPtrGetter*[T](getter: GDExtensionPtrGetter, base: GDExtensionTypePtr): T =
    getter(base, addr result)


