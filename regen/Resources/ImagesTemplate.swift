{% if parent %}
extension {{ parent }} {
    enum {{ className }} {
    {% for image in images %}    static let {{ image.propertyName }}: String = "{{ image.imageSetName }}"
    {% endfor %}}
}
{% else %}
enum {{ className }} {
{% for image in images %}    static let {{ image.propertyName }}: String = "{{ image.imageSetName }}"
{% endfor %}}
{% endif %}

