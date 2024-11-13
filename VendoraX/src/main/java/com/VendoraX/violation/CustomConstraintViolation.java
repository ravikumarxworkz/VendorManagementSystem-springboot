package com.VendoraX.violation;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Path;
import jakarta.validation.metadata.ConstraintDescriptor;

public class CustomConstraintViolation<T> implements ConstraintViolation<T> {

    private final String propertyName;
    private final String message;

    public CustomConstraintViolation(String propertyName, String message) {
        this.propertyName = propertyName;
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }

    // Implement the other methods from ConstraintViolation interface

    public String getExecutableName() {
        return null;
    }

    @Override
    public T getRootBean() {
        return null;
    }

    @Override
    public Class<T> getRootBeanClass() {
        return null;
    }

    @Override
    public Object getLeafBean() {
        return null;
    }

    @Override
    public Path getPropertyPath() {
        return null;
    }

    @Override
    public Object getInvalidValue() {
        return null;
    }

    @Override
    public ConstraintDescriptor<?> getConstraintDescriptor() {
        return null;
    }

  

    @Override
    public Object[] getExecutableParameters() {
        return new Object[0];
    }

    @Override
    public Object getExecutableReturnValue() {
        return null;
    }

  

    @Override
    public String toString() {
        return "CustomConstraintViolation{" +
                "propertyName='" + propertyName + '\'' +
                ", message='" + message + '\'' +
                '}';
    }

	@Override
	public String getMessageTemplate() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public <U> U unwrap(Class<U> type) {
		// TODO Auto-generated method stub
		return null;
	}
}


