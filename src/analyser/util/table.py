from IPython.core.display import display, HTML

# utility function for tables
def display_table(rows, column_names=None):
    table_str = "<table>"
    if column_names is not None:
        table_str += "<thead><tr>"
        for column_name in column_names:
            table_str += "<th>{}</th>".format(column_name)
        table_str += "</tr></thead>"
    nr_rows = len(rows)
    table_str += "<tbody>"
    for row in rows:
        table_str += "<tr>"
        for col in row:
            table_str += "<td>{}</td>".format(str(col))
        table_str += "</tr>"
    table_str += "</tbody></table>"
    display(HTML(table_str))
