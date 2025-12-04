// app/javascript/controllers/member_form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["departmentSelect", "positionSelect"]

  async updateDepartments(event) {
    const branchId = event.target.value
    
    if (!branchId) {
      this.departmentSelectTarget.innerHTML = '<option value="">Select Department</option>'
      this.positionSelectTarget.innerHTML = '<option value="">Select Position</option>'
      return
    }

    try {
      const response = await fetch(`/api/departments?branch_id=${branchId}`)
      const departments = await response.json()
      
      this.departmentSelectTarget.innerHTML = '<option value="">Select Department</option>' +
        departments.map(dept => `<option value="${dept.id}">${dept.name}</option>`).join('')
      
      this.positionSelectTarget.innerHTML = '<option value="">Select Position</option>'
    } catch (error) {
      console.error('Error fetching departments:', error)
    }
  }

  async updatePositions(event) {
    const departmentId = event.target.value
    
    if (!departmentId) {
      this.positionSelectTarget.innerHTML = '<option value="">Select Position</option>'
      return
    }

    try {
      const response = await fetch(`/api/positions?department_id=${departmentId}`)
      const positions = await response.json()
      
      this.positionSelectTarget.innerHTML = '<option value="">Select Position</option>' +
        positions.map(pos => {
          const uniqueLabel = pos.unique ? ' (Unique Position)' : ''
          const availableLabel = pos.unique && !pos.available ? ' [Taken]' : ''
          return `<option value="${pos.id}" ${pos.unique && !pos.available ? 'disabled' : ''}>${pos.name}${uniqueLabel}${availableLabel}</option>`
        }).join('')
    } catch (error) {
      console.error('Error fetching positions:', error)
    }
  }
}