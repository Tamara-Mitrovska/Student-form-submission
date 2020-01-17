import React from 'react';
import axios from 'axios';
import { Button, Checkbox, Form } from 'semantic-ui-react';

class StudentForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
          nameWithInitial: "",
          fullName: "",
          religion:"",
          ethnicity:"",
          dateOfBirth:"",
          grade:"",
          gender:"",
          address:""
        };
    
        this.handleInputChange = this.handleInputChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
      }
    
      handleInputChange(event) {
        const target = event.target;
        const value = target.type === 'checkbox' ? target.checked : target.value;
        const name = target.name;
    
        this.setState({
          [name]: value
        });
      }
      handleSubmit(event) {
        console.log(this.state);
        axios.post("http://0.0.0.0:9090/students/info", this.state).then(function(response){
            JSON.stringify(response);
            console.log(response);
        })
        event.preventDefault();
      }

    
      render() {
        return (
        <Form onSubmit={this.handleSubmit}>
            <Form.Group widths='equal'>
                <Form.Field>
                <label>NAME WITH INITIAL</label>
                <input placeholder='Name with initial' name="nameWithInitial" onChange={this.handleInputChange} value={this.state.nameWithInitial}/>
                </Form.Field>
                <Form.Field>
                <label>FULL NAME</label>
                <input placeholder='Full name' name="fullName" onChange={this.handleInputChange} value={this.state.fullName}/>
                </Form.Field>
            </Form.Group>
            <Form.Group widths='equal'>
                <Form.Field>
                <label>RELIGION</label>
                <input placeholder='Religion' name="religion" onChange={this.handleInputChange} value={this.state.religion}/>
                </Form.Field>
                <Form.Field>
                <label>ETHNICITY</label>
                <input placeholder='Ethnicity' name="ethnicity" onChange={this.handleInputChange} value={this.state.ethicity}/>
                </Form.Field>
            </Form.Group>
            <Form.Group widths='equal'>
                <Form.Field>
                <label>DATE OF BIRTH</label>
                <input placeholder='Date of birth' name="dateOfBirth" onChange={this.handleInputChange} value={this.state.dateOfBirth}/>
                </Form.Field>
                <Form.Field>
                <label>GRADE</label>
                <input placeholder='Grade' name="grade" onChange={this.handleInputChange} value={this.state.grade}/>
                </Form.Field>
                <Form.Field>
                <label>GENDER</label>
                <input placeholder='Gender' name="gender" onChange={this.handleInputChange} value={this.state.gender}/>
                </Form.Field>
            </Form.Group>
            <Form.Field>
            <label>ADDRESS</label>
            <input placeholder='Address' name="address" onChange={this.handleInputChange} value={this.state.address}/>
            </Form.Field>
            <Form.Field>
            <Checkbox label='I agree to the Terms and Conditions' />
            </Form.Field>
            <Button type='submit'>Submit</Button>
        </Form>
        );
      }
  }
  
  export default StudentForm;