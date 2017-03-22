import logging

def do_defined_vars_to_list(vars):
    from jinja2.runtime import Undefined
    logging.info(vars)

    lst = []
    for v in vars:
        if not isinstance(v, Undefined) and v:
            lst = lst + [v]
    return lst


class FilterModule(object):
    ''' Custom Ansible jinja2 filters '''

    def filters(self):
        return {
            'defined_vars_to_list': do_defined_vars_to_list
        }
