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
	internal override UIView CreateInternal()
	{
		var id = CreateImpl();
		iOS.UIKit.UIView v = new iOS.UIKit.UIView(id);
		return v;
	}

	[Foreign(Language.ObjC)]
	extern(iOS) ObjC.ID CreateImpl()
	@{
		UIView *previewView = [UIApplication sharedApplication].keyWindow;

		NSLog(@"This is it: %@", @"This is my string text!");
		[[MTBBarcodeScanner alloc] initWithPreviewView:previewView];
		return previewView;
	@}

	protected override void Attach()
	{
		// CreateInternal();
	}

	protected override void Detach()
	{
	}

	public override float2 GetMarginSize( LayoutParams lp ) {
		return float2(55);
	}

}

extern (!iOS) public class BarcodeScannerImpl : Fuse.iOS.Controls.Control<BarcodeScanner> {}
