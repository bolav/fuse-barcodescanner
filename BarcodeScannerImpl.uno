using Uno;
using Uno.Collections;
using Fuse;
using iOS.UIKit;
using Uno.Compiler.ExportTargetInterop;

[Require("Source.Import", "MTBBarcodeScanner.h")]
[TargetSpecificImplementation]
extern (iOS)
public class BarcodeScannerImpl : Fuse.iOS.Controls.Control<BarcodeScanner>
{
	ObjC.ID previewView;
	ObjC.ID scanner;
	internal override UIView CreateInternal()
	{
		previewView = CreatePreviewView();
		scanner = CreateImpl(previewView);
		iOS.UIKit.UIView v = new iOS.UIKit.UIView(previewView);
		return v;
	}

	[Foreign(Language.ObjC)]
	extern(iOS) ObjC.ID CreatePreviewView()
	@{
		return [[UIView alloc] init];
	@}

	[Foreign(Language.ObjC)]
	extern(iOS) ObjC.ID CreateImpl(ObjC.ID previewView)
	@{
		NSLog(@"This is it: %@", @"This is my string text!");
		MTBBarcodeScanner *s = [[MTBBarcodeScanner alloc] initWithPreviewView:previewView];
		return s;
	@}

	[Require("Entity","BarcodeScannerImpl.Scanned(string)")]
	[Foreign(Language.ObjC)]
	extern(iOS) void StartImpl(ObjC.ID s)
	@{
		[MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
		    if (success) {

		        [s startScanningWithResultBlock:^(NSArray *codes) {
		            AVMetadataMachineReadableCodeObject *code = [codes firstObject];
		            NSLog(@"Found code: %@", code.stringValue);
		            @{BarcodeScannerImpl:Of(_this).Scanned(string):Call(code.stringValue)};

		            [s stopScanning];
		        }];

		    } else {
		    	NSLog(@"The user denied access to the camera");
		    }
		}];
	@}

	public void Scanned (string scanned) {
		SemanticControl.SetCode(scanned, this);
	}

	protected override void Attach()
	{
		// CreateInternal();
		StartImpl(scanner);
		debug_log "Started scanner";
	}

	protected override void Detach()
	{
	}

	public override float2 GetMarginSize( LayoutParams lp ) {
		return float2(55);
	}

}

extern (!iOS) public class BarcodeScannerImpl : Fuse.iOS.Controls.Control<BarcodeScanner> {}
