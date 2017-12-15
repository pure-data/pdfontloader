/*
* hello.c -- A minimal Tcl C extension.
*/
#include <tcl.h>

static int
Pdloader_loadfont(ClientData cdata, Tcl_Interp *interp, int objc, Tcl_Obj *const objv[])
{
    if(objc != 2) {
        Tcl_WrongNumArgs(interp, 1, objv, "filename");
        return TCL_ERROR;
    }
    Tcl_DString ds;
    Tcl_Encoding unicode;
    int len, ret = TCL_OK;
    const char *path = Tcl_GetStringFromObj(objv[1], &len);
    if(path == NULL) {
        return TCL_ERROR;
    }
    Tcl_DStringInit(&ds);
    unicode = Tcl_GetEncoding(interp, "unicode");
    Tcl_UtfToExternalDString(unicode, path, len, &ds);
    if(!AddFontResourceExW(Tcl_DStringValue(&ds), FR_PRIVATE, NULL) == 0) {
        ret = TCL_ERROR;
    }
    Tcl_DStringFree(&ds);
    Tcl_FreeEncoding(unicode);
    if(ret == TCL_ERROR) {
        Tcl_SetObjResult(interp, Tcl_ObjPrintf("couldn't load font: %s", path));
    }
    return ret;
}

/*
* Hello_Init -- Called when Tcl loads your extension.
*/
extern DLLEXPORT int Pdloader_Init(Tcl_Interp *interp)
{
    printf("ka\n");
    if(Tcl_InitStubs(interp, TCL_VERSION, 0) == NULL) {
        return TCL_ERROR;
    }
    //if(Tcl_PkgProvide(interp, "Pdloader", "1.0") == TCL_ERROR) {
    //    return TCL_ERROR;
    //}
    if(!Tcl_CreateObjCommand(interp, "pdloader::loadfont", Pdloader_loadfont, NULL, NULL)) {
        return TCL_ERROR;
    }
    return TCL_OK;
}
