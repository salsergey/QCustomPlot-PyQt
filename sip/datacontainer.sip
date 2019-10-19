/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


template <DataType>
class QCPDataContainer
{
%TypeHeaderCode
#include <QCustomPlot/src/datacontainer.h>
%End
public:
  //typedef QVector<DataType>::const_iterator const_iterator;
  //typedef QVector<DataType>::iterator iterator;
  
  QCPDataContainer();
  
  // getters:
  int size() const;
  bool isEmpty() const;
  bool autoSqueeze() const;
  
  // setters:
  void setAutoSqueeze(bool enabled);
  
  // non-virtual methods:
  void set(const QCPDataContainer<DataType> &data);
  void set(const QVector<DataType> &data, bool alreadySorted=false);
  void add(const QCPDataContainer<DataType> &data);
  void add(const QVector<DataType> &data, bool alreadySorted=false);
  void add(const DataType &data);
  void removeBefore(double sortKey);
  void removeAfter(double sortKey);
  void remove(double sortKeyFrom, double sortKeyTo);
  void remove(double sortKey);
  void clear();
  void sort();
  void squeeze(bool preAllocation=true, bool postAllocation=true);
  
  //const_iterator constBegin() const;
  //const_iterator constEnd() const;
  //iterator begin();
  //iterator end();
  //const_iterator findBegin(double sortKey, bool expandedRange=true) const;
  //const_iterator findEnd(double sortKey, bool expandedRange=true) const;
  //const_iterator at(int index) const;
  QCPRange keyRange(bool &foundRange, QCP::SignDomain signDomain=QCP::sdBoth);
  QCPRange valueRange(bool &foundRange, QCP::SignDomain signDomain=QCP::sdBoth, const QCPRange &inKeyRange=QCPRange());
  QCPDataRange dataRange() const;
  //void limitIteratorsToDataRange(const_iterator &begin, const_iterator &end, const QCPDataRange &dataRange) const;

protected:
  // non-virtual methods:
  void preallocateGrow(int minimumPreallocSize);
  void performAutoSqueeze();
};
