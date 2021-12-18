import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["category", "output"];
    filter() {
        // console.log(`Hello ${this.categoryTarget.value}`)
        const value = this.categoryTarget.value
        fetch(
            `/filter_products?category=${value}`,
            { method: 'POST',
                headers: { accept: 'text/vnd.turbo-stream.html'}})
            .then((response) => response.text())
            .then(data => console.log(data))
    }
}
