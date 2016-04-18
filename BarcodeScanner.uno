using Uno;
using Uno.Collections;
using Fuse;
using Fuse.Scripting;
using Fuse.Reactive;
using Uno.Compiler.ExportTargetInterop;

[Require("Source.Include", "MTBBarcodeScanner.h")]
[ForeignInclude(Language.ObjC, "MTBBasicExampleViewController.h")]
public class BarcodeScanner : NativeModule {

	public BarcodeScanner(){
		AddMember(new NativeFunction("scanner", 
			(NativeCallback)Scanner));
	}
	object Scanner(Context c, object[] args){
		Scanner();

		return null;
	}

	[Foreign(Language.ObjC)]

	static extern(iOS) void Scanner()
	@{
		UIView *previewView = [UIApplication sharedApplication].keyWindow;

		NSLog(@"This is it: %@", @"This is my string text!");
		[[MTBBarcodeScanner alloc] initWithPreviewView:previewView];
	@}
	static extern(!iOS) void Scanner(){
		debug_log("Barcode Scanner is not supported on this platform");
	}

}
