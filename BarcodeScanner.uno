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
		MTBBarcodeScanner *s = [[MTBBarcodeScanner alloc] initWithPreviewView:previewView];
		[MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
		    if (success) {

		        [s startScanningWithResultBlock:^(NSArray *codes) {
		            AVMetadataMachineReadableCodeObject *code = [codes firstObject];
		            NSLog(@"Found code: %@", code.stringValue);

		            [s stopScanning];
		        }];

		    } else {
		    	NSLog(@"The user denied access to the camera");
		        // The user denied access to the camera
		    }
		}];

	@}
	static extern(!iOS) void Scanner(){
		debug_log("Barcode Scanner is not supported on this platform");
	}

}
