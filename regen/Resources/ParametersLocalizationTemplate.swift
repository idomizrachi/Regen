import Foundation

public struct {{ className }} {
{% for property in properties %}
    static func {{ property.property }}({% for param in property.params %}{{ param.key }}: String{% if forloop.last == false %}, {% endif %}{% endfor %}) {
        return localize("{{ property.key }}",
                        defaultValue: "{{ property.value }}",
                        parameters: {% if property.params.count == 0 %}nil{% else %} [{% for param in property.params %}"{{ param.value }}": {{ param.key }}{% if forloop.last == false %}, {% endif %}{% empty %}:{% endfor %}]{% endif %})
    }
{% endfor %}
}


