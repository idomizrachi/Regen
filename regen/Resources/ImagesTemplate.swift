public struct {{ className }} {
{% for folder in folders %} let {{ folder.propertyName }}: {{folder.className }} = {{folder.className }}()

{% for image in images %} let {{ image.propertyName }}: String = "{{ image.imageSetName }}"
}
