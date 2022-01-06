"use strict";
Object.defineProperty(exports, "__esModule", { value: true });

class MonacoEditor extends HTMLElement {
    constructor() {
        super();
        this.editor = null;
        this._form = null;
        // keep reference to <form> for cleanup
        this._form = null;
        this._handleFormData = this._handleFormData.bind(this);
    }
    // attributeChangedCallback will be called when the value of one of these attributes is changed in html
    static get observedAttributes() {
        return ['value', 'language'];
    }
    attributeChangedCallback(name, oldValue, newValue) {
        if (this.editor) {
            if (name === 'value') {
                this.editor.setValue(newValue);
            }
            if (name === 'language') {
                const currentModel = this.editor.getModel();
                if (currentModel) {
                    currentModel.dispose();
                }
                this.editor.setModel(monaco.editor.createModel(this.getEditorValue(), newValue));
            }
        }
    }
    setEditorValue(newValue) {
        this.editor.setValue(newValue);
    }



    connectedCallback() {
        this._form = this._findContainingForm();
        if (this._form) {
            this._form.addEventListener('formdata', this._handleFormData);
        }
        // editor
        const editor = document.createElement('div');
        editor.className = "editor-container";
        this.appendChild(editor);
        // window.editor is accessible.
        var init = () => {
            require(['vs/editor/editor.main'], () => {

                monaco.editor.defineTheme('rf-dark', {
                    base: 'hc-black',
                    inherit: true,
                    rules: [
                        { background: '292f33' },
                        { token: 'delimiter', foreground: '3b94d9', fontStyle: 'italic' },
                        { token: 'variable', foreground: '77c7f7', fontStyle: 'italic' },
                        { token: 'type.robotframework', foreground: 'd0d0d0', fontStyle: 'italic' },
                    ],
                    colors: {
                        'editor.background': '#292f33',
                    }
                });
                this.editor = monaco.editor.create(editor, {
                    theme: 'rf-dark', //(window.getComputedStyle(document.querySelector("body")).colorScheme === 'dark') ? "rf-dark" : "vs",
                    //model: monaco.editor.createModel(this.getAttribute("value"), this.getAttribute("language")),
                    value: this.getAttribute("value"),
                    language: this.getAttribute("language"),
                    wordWrap: 'wordWrapColumn',
                    wordWrapColumn: 40,

                    // Set this to false to not auto word wrap minified files
                    wordWrapMinified: true,

                    // try "same", "indent" or "none"
                    wrappingIndent: 'indent',
                    minimap: {
                        enabled: false
                    },
                    scrollbar: {
                        vertical: 'hidden',
                        horizontal: 'visible'
                    },
                });
                this.editor.getModel().updateOptions({ tabSize: 4, wordWrap: 'off' });
                this.editor.addCommand(
                    monaco.KeyCode.Tab, () => {
                        this.editor.trigger('keyboard', 'type', { text: "    " });
                    },
                    'editorTextFocus && !editorHasSelection && !inSnippetMode && !suggestWidgetVisible'
                );
            });
            window.removeEventListener("load", init);
        };
        window.addEventListener("load", init);
    }
    disconnectedCallback() {
        if (this._form) {
            this._form.removeEventListener('formdata', this._handleFormData);
            this._form = null;
        }
    }
    getEditorValue() {
        if (this.editor) {
            return this.editor.getModel().getValue();
        }
        return null;
    }
    _handleFormData(ev) {
        ev.formData.append(this.getAttribute('name'), this.getEditorValue());
    }
    _findContainingForm() {
        // can only be in a form in the same "scope", ShadowRoot or Document
        const root = this.getRootNode();
        if (root instanceof Document || root instanceof Element) {
            const forms = Array.from(root.querySelectorAll('form'));
            // we can only be in one <form>, so the first one to contain us is the correct one
            return forms.find((form) => form.contains(this)) || null;
        }
        return null;
    }
}

customElements.define('monaco-editor', MonacoEditor);



//# sourceMappingURL=editor.js.map