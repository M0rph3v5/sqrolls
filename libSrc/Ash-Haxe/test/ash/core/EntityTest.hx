package ash.core;

import org.hamcrest.MatchersBase;
import massive.munit.async.AsyncFactory;

import ash.core.Entity;
import ash.Mocks;

class EntityTest extends MatchersBase
{
    private var entity:Entity;

    @Before
    public function createEntity():Void
    {
        entity = new Entity();
    }

    @After
    public function clearEntity():Void
    {
        entity = null;
    }

    @Test
    public function addReturnsReferenceToEntity():Void
    {
        var component:MockComponent = new MockComponent();
        var e:Entity = entity.add(component);
        assertThat(e, sameInstance(entity));
    }

    @Test
    public function canStoreAndRetrieveComponent():Void
    {
        var component:MockComponent = new MockComponent();
        entity.add(component);
        assertThat(entity.get(MockComponent), sameInstance(component));
    }

    @Test
    public function canStoreAndRetrieveMultipleComponents():Void
    {
        var component1:MockComponent = new MockComponent();
        entity.add(component1);
        var component2:MockComponent2 = new MockComponent2();
        entity.add(component2);
        assertThat(entity.get(MockComponent), sameInstance(component1));
        assertThat(entity.get(MockComponent2), sameInstance(component2));
    }

    @Test
    public function canReplaceComponent():Void
    {
        var component1:MockComponent = new MockComponent();
        entity.add(component1);
        var component2:MockComponent = new MockComponent();
        entity.add(component2);
        assertThat(entity.get(MockComponent), sameInstance(component2));
    }

    @Test
    public function canStoreBaseAndExtendedComponents():Void
    {
        var component1:MockComponent = new MockComponent();
        entity.add(component1);
        var component2:MockComponentExtended = new MockComponentExtended();
        entity.add(component2);
        assertThat(entity.get(MockComponent), sameInstance(component1));
        assertThat(entity.get(MockComponentExtended), sameInstance(component2));
    }

    @Test
    public function canStoreExtendedComponentAsBaseType():Void
    {
        var component:MockComponentExtended = new MockComponentExtended();
        entity.add(component, MockComponent);
        assertThat(entity.get(MockComponent), sameInstance(component));
    }

    @Test
    public function getReturnNullIfNoComponent():Void
    {
        assertThat(entity.get(MockComponent), nullValue());
    }

    @Test
    public function willRetrieveAllComponents():Void
    {
        var component1:MockComponent = new MockComponent();
        entity.add(component1);
        var component2:MockComponent2 = new MockComponent2();
        entity.add(component2);
        var all:Array<Dynamic> = entity.getAll();
        assertThat(all.length, equalTo(2));

        var components:Array<Dynamic> = [component1, component2];
        assertThat(all, hasItems(components));
    }

    @Test
    public function hasComponentIsFalseIfComponentTypeNotPresent():Void
    {
        entity.add(new MockComponent2());
        assertThat(entity.has(MockComponent), is(false));
    }

    @Test
    public function hasComponentIsTrueIfComponentTypeIsPresent():Void
    {
        entity.add(new MockComponent());
        assertThat(entity.has(MockComponent), is(true));
    }

    @Test
    public function canRemoveComponent():Void
    {
        var component:MockComponent = new MockComponent();
        entity.add(component);
        entity.remove(MockComponent);
        assertThat(entity.has(MockComponent), is(false));
    }

    @AsyncTest
    public function storingComponentTriggersAddedSignal(async:AsyncFactory):Void
    {
        var component:MockComponent = new MockComponent();
        entity.componentAdded.add(async.createHandler(this, function():Void
        {}));
        entity.add(component);
    }

    @AsyncTest
    public function removingComponentTriggersRemovedSignal(async:AsyncFactory):Void
    {
        var component:MockComponent = new MockComponent();
        entity.add(component);
        entity.componentRemoved.add(async.createHandler(this, function():Void
        {}));
        entity.remove(MockComponent);
    }

    @AsyncTest
    public function componentAddedSignalContainsCorrectParameters(async:AsyncFactory):Void
    {
        var component:MockComponent = new MockComponent();
        entity.componentAdded.add(async.createHandler(this, testSignalContent, 10));
        entity.add(component);
    }

    @AsyncTest
    public function componentRemovedSignalContainsCorrectParameters(async:AsyncFactory):Void
    {
        var component:MockComponent = new MockComponent();
        entity.add(component);
        entity.componentRemoved.add(async.createHandler(this, testSignalContent, 10));
        entity.remove(MockComponent);
    }

    private function testSignalContent(signalEntity:Entity, componentClass:Class<Dynamic>):Void
    {
        assertThat(signalEntity, sameInstance(entity));
        assertThat(componentClass, sameInstance(MockComponent));
    }

    @Test
    public function testEntityHasNameByDefault():Void
    {
        entity = new Entity();
        assertThat(entity.name.length, greaterThan(0));
    }

    @Test
    public function testEntityNameStoredAndReturned():Void
    {
        var name:String = "anything";
        entity = new Entity( name );
        assertThat(entity.name, equalTo(name));
    }

    @Test
    public function testEntityNameCanBeChanged():Void
    {
        entity = new Entity( "anything" );
        entity.name = "otherThing";
        assertThat(entity.name, equalTo("otherThing"));
    }

    @AsyncTest
    public function testChangingEntityNameDispatchesSignal(async:AsyncFactory):Void
    {
        entity = new Entity( "anything" );
        entity.nameChanged.add(async.createHandler(this, testNameChangedSignal, 10));
        entity.name = "otherThing";
    }

    private function testNameChangedSignal(signalEntity:Entity, oldName:String):Void
    {
        assertThat(signalEntity, sameInstance(entity));
        assertThat(entity.name, equalTo("otherThing"));
        assertThat(oldName, equalTo("anything"));
    }
}
