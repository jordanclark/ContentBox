/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="contentbox.model.ui.editors.EditorService"{

	void function setup(){
		super.setup();
		
		mockWireBox.$("getInstance", new MockEditor() );
		
		// init the model object
		model.init( mockWireBox );
	}
	
	function testGetRegisteredEditors(){
		model.getEditors()["test"] = this;
		model.getEditors()["Awesome"] = this;
		a = model.getRegisteredEditors();
		//debug(a);
		assertEquals( "Awesome", a[1] );
		assertEquals( "mock-editor", a[2] );
		assertEquals( "test", a[3] );
	}
	
	function testregisterEditor(){
		editor = getMockBox().prepareMock( new MockEditor() );
		model.registerEditor( editor );
		assertEquals( editor, model.getEditor("mock-editor") );
	}
	
	function testUnregisterEditor(){
		editor = getMockBox().prepareMock( new MockEditor() );
		model.registerEditor( editor ).unRegisterEditor( "mock-editor" );
		assertFalse( structKeyExists( model.getEditors(), "mock-editor") );
	}
	

}
