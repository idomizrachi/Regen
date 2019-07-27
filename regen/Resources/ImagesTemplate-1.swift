public enum {{ className }} {
     {% if root %}static let sharedInstance = {{ className }}()

    {% endif %}{% for folder in folders %} let _{{ folder.propertyName }}: {{folder.className }} = {{folder.className }}()
    {% endfor %}
    {% for image in images %} let {{ image.propertyName }}: String = "{{ image.imageSetName }}"
    {% endfor %}
}
